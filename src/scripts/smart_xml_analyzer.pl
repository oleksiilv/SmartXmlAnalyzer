#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use Params::Validate qw(:all);
use feature qw(say);
use XML::LibXML;
use Data::Dumper;
use Readonly;

Readonly::Scalar our $XPATH_PREFERENCE_HIGH => 3;
Readonly::Scalar our $XPATH_PREFERENCE_MEDIUM => 2;
Readonly::Scalar our $XPATH_PREFERENCE_LOW => 1;
Readonly::Scalar our $LOG_DELIMITER => "==============================";

say "Hello World!";

my $usage_str = "Usage: $0 <origin_html_file_path> <actual_html_file_path> <target_element_id_on_origin>\n";

my $origin_html_file_path = shift or die $usage_str;
my $actual_html_file_path = shift or die $usage_str;
my $target_element_id_on_origin = shift or die $usage_str;

say "Original html file is '$origin_html_file_path'";
say "Actual html file is '$actual_html_file_path'";
say "Id of the target element in original html is '$target_element_id_on_origin'";

my $xpath_to_target_element_within_actual_html = analyze_xml(
    origin_html_file_path       => $origin_html_file_path,
    actual_html_file_path       => $actual_html_file_path,
    target_element_id_on_origin => $target_element_id_on_origin
);

say $LOG_DELIMITER;
say "Recommeded xpath is '$xpath_to_target_element_within_actual_html'";

sub analyze_xml {
    my %args = validate(
        @_,
        {
            origin_html_file_path       => 1,
            actual_html_file_path       => 1,
            target_element_id_on_origin => 1,
        }
    );

    my $origin_html_file_path = $args{origin_html_file_path};
    my $actual_html_file_path = $args{actual_html_file_path};
    my $target_element_id_on_origin = $args{target_element_id_on_origin};

    say $LOG_DELIMITER;
    say "Generating list of preferred xpaths based on original html";
    my %preferred_xpaths = %{ generate_preferred_xpaths(
        origin_html_file_path       => $origin_html_file_path,
        target_element_id_on_origin => $target_element_id_on_origin) };

    say "List of preferred xpaths based on original html: ";
    foreach my $xpath (keys %preferred_xpaths) {
        say "xpath '$xpath' has a preference value " . $preferred_xpaths{$xpath};
    }

    say $LOG_DELIMITER;
    say "Generating list of preferred nodes within actual html based on preffered xpaths";
    my %preferred_nodes = %{analyze_actual_html_based_on_preferred_xpath(
        actual_html_file_path => $actual_html_file_path,
        preferred_xpaths      => \%preferred_xpaths
    )};
    say "List of preferred nodes within actual html based on preffered xpaths (the higher preference value is better): ";
    foreach my $node (sort {$preferred_nodes{$a} <=> $preferred_nodes{$b}} keys %preferred_nodes) {
        say "xpath '$node' has a preference value " . $preferred_nodes{$node};
    }

    return (sort {$preferred_nodes{$b} <=> $preferred_nodes{$a}} keys %preferred_nodes)[0];

}

sub generate_preferred_xpaths {
    my %args = validate(
        @_,
        {
            origin_html_file_path       => 1,
            target_element_id_on_origin => 1,
        }
    );

    my $origin_html_file_path = $args{origin_html_file_path};
    my $target_element_id_on_origin = $args{target_element_id_on_origin};

    my %preferred_xpaths;

    my $dom = XML::LibXML->load_xml(location => $origin_html_file_path);

    my $xpath_by_id = "//*[\@id='" . $target_element_id_on_origin . "']";
    $preferred_xpaths{$xpath_by_id} = $XPATH_PREFERENCE_LOW;

    my $target_nodes = $dom->findnodes($xpath_by_id);

    if (@$target_nodes != 1) {
        die "Cannot detect unique target element within origin xml by its id. Number of detected elements: " . @$target_nodes;
    }

    my $target_node = $target_nodes->[0];

    my $xpath_by_tree_tags = $target_node->nodePath();
    $preferred_xpaths{$xpath_by_tree_tags} = $XPATH_PREFERENCE_LOW;

    for my $attribute ($target_node->getAttributes) {
        my $attribute_name = $attribute->nodeName;
        my $attribute_value = $attribute->value;
        my $xpath_by_attribute = "//*[\@" . $attribute_name . "='" . $attribute_value . "']";
        $preferred_xpaths{$xpath_by_attribute} = $XPATH_PREFERENCE_LOW;
    }

    #todo: add more preferred xpaths here

    return \%preferred_xpaths;
}

sub analyze_actual_html_based_on_preferred_xpath {
    my %args = validate(
        @_,
        {
            actual_html_file_path => 1,
            preferred_xpaths      => 1,
        }
    );

    my $actual_html_file_path = $args{actual_html_file_path};
    my %preferred_xpaths = %{$args{preferred_xpaths}};

    my %preferred_nodes;

    my $dom = XML::LibXML->load_xml(location => $actual_html_file_path);

    foreach my $xpath (keys %preferred_xpaths) {
        my $preference_value = $preferred_xpaths{$xpath};

        foreach my $node ($dom->findnodes($xpath)) {
            my $node_path = $node->nodePath();
            $preferred_nodes{$node_path}++;
        }
    }

    return \%preferred_nodes;
}
