# SmartXmlAnalyzer
Smart XML Analyzer

# Examples of output based on provided samples
## sample-0-origin.html VS sample-1-evil-gemini.html
```$xslt
perl src\scripts\smart_xml_analyzer.pl example\sample-0-origin.html example\sample-1-evil-gemini.html make-everything
-ok-button
Hello World!
Original html file is 'example\sample-0-origin.html'
Actual html file is 'example\sample-1-evil-gemini.html'
Id of the target element in original html is 'make-everything-ok-button'
==============================
Generating list of preferred xpaths based on original html
List of preferred xpaths based on original html:
xpath '//*[@href='#ok']' has a preference value 1
xpath '//*[@class='btn btn-success']' has a preference value 1
xpath '/html/body/div/div/div[3]/div[1]/div/div[2]/a' has a preference value 1
xpath '//*[@title='Make-Button']' has a preference value 1
xpath '//*[@id='make-everything-ok-button']' has a preference value 1
xpath '//*[@onclick='javascript:window.okDone(); return false;']' has a preference value 1
xpath '//*[@rel='next']' has a preference value 1
==============================
Generating list of preferred nodes within actual html based on preffered xpaths
List of preferred nodes within actual html based on preffered xpaths (the higher preference value is better):
xpath '/html/body/div/nav/ul/li[1]/ul/li[7]/a' has a preference value 1
xpath '/html/body/div/div/div[3]/div[1]/div/div[2]/a[1]' has a preference value 3
xpath '/html/body/div/div/div[3]/div[1]/div/div[2]/a[2]' has a preference value 4
==============================
Recommeded xpath is '/html/body/div/div/div[3]/div[1]/div/div[2]/a[2]'
```

## sample-0-origin.html VS sample-2-container-and-clone.html
```$xslt
perl src\scripts\smart_xml_analyzer.pl example\sample-0-origin.html example\sample-2-container-and-clone.html make-ev
erything-ok-button
Hello World!
Original html file is 'example\sample-0-origin.html'
Actual html file is 'example\sample-2-container-and-clone.html'
Id of the target element in original html is 'make-everything-ok-button'
==============================
Generating list of preferred xpaths based on original html
List of preferred xpaths based on original html:
xpath '//*[@onclick='javascript:window.okDone(); return false;']' has a preference value 1
xpath '/html/body/div/div/div[3]/div[1]/div/div[2]/a' has a preference value 1
xpath '//*[@rel='next']' has a preference value 1
xpath '//*[@id='make-everything-ok-button']' has a preference value 1
xpath '//*[@href='#ok']' has a preference value 1
xpath '//*[@class='btn btn-success']' has a preference value 1
xpath '//*[@title='Make-Button']' has a preference value 1
==============================
Generating list of preferred nodes within actual html based on preffered xpaths
List of preferred nodes within actual html based on preffered xpaths (the higher preference value is better):
xpath '/html/body/div/div/div[3]/div[2]/div/div[2]/a[2]' has a preference value 1
xpath '/html/body/div/div/div[3]/div[1]/div/div[2]/div/a' has a preference value 3
==============================
Recommeded xpath is '/html/body/div/div/div[3]/div[1]/div/div[2]/div/a'
```

## sample-0-origin.html VS sample-3-the-escape.html
```$xslt
perl src\scripts\smart_xml_analyzer.pl example\sample-0-origin.html example\sample-3-the-escape.html make-everything-
ok-button
Hello World!
Original html file is 'example\sample-0-origin.html'
Actual html file is 'example\sample-3-the-escape.html'
Id of the target element in original html is 'make-everything-ok-button'
==============================
Generating list of preferred xpaths based on original html
List of preferred xpaths based on original html:
xpath '//*[@href='#ok']' has a preference value 1
xpath '//*[@id='make-everything-ok-button']' has a preference value 1
xpath '//*[@rel='next']' has a preference value 1
xpath '//*[@class='btn btn-success']' has a preference value 1
xpath '//*[@onclick='javascript:window.okDone(); return false;']' has a preference value 1
xpath '//*[@title='Make-Button']' has a preference value 1
xpath '/html/body/div/div/div[3]/div[1]/div/div[2]/a' has a preference value 1
==============================
Generating list of preferred nodes within actual html based on preffered xpaths
List of preferred nodes within actual html based on preffered xpaths (the higher preference value is better):
xpath '/html/body/div/div/div[3]/div[1]/div/div[2]/a' has a preference value 3
xpath '/html/body/div/div/div[3]/div[1]/div/div[3]/a' has a preference value 4
==============================
Recommeded xpath is '/html/body/div/div/div[3]/div[1]/div/div[3]/a'
```

## sample-0-origin.html VS sample-4-the-mash.html
```$xslt
perl src\scripts\smart_xml_analyzer.pl example\sample-0-origin.html example\sample-4-the-mash.html make-everything-ok
-button
Hello World!
Original html file is 'example\sample-0-origin.html'
Actual html file is 'example\sample-4-the-mash.html'
Id of the target element in original html is 'make-everything-ok-button'
==============================
Generating list of preferred xpaths based on original html
List of preferred xpaths based on original html:
xpath '//*[@id='make-everything-ok-button']' has a preference value 1
xpath '//*[@class='btn btn-success']' has a preference value 1
xpath '//*[@title='Make-Button']' has a preference value 1
xpath '//*[@rel='next']' has a preference value 1
xpath '//*[@href='#ok']' has a preference value 1
xpath '/html/body/div/div/div[3]/div[1]/div/div[2]/a' has a preference value 1
xpath '//*[@onclick='javascript:window.okDone(); return false;']' has a preference value 1
==============================
Generating list of preferred nodes within actual html based on preffered xpaths
List of preferred nodes within actual html based on preffered xpaths (the higher preference value is better):
xpath '/html/body/div/div/div[3]/div[1]/div/div[2]/button' has a preference value 1
xpath '/html/body/div/div/div[3]/div[1]/div/div[3]/a' has a preference value 4
==============================
Recommeded xpath is '/html/body/div/div/div[3]/div[1]/div/div[3]/a'
```

# Script dependencies

Perl version 5.10 or higher

Perl Modules:
* Params::Validate
* Readonly

# Execs and bundles available within repository

Some exec and bundles files are available here: [execs](execs).

Windows exe file:

```aidl
execs\smart_xml_analyzer.exe example\sample-0-origin.html example\sample-1-evil-gemini.html make-everything-ok-button
```

## Experimental

par archive (requires perl and par to be installed):

```aidl
par experimental\execs\smart_xml_analyzer.par example\sample-0-origin.html example\sample-1-evil-gemini.html make-everything-ok-button
```

Perl bundle script (requires perl and par to be installed):

```aidl
perl experimental\execs\smart_xml_analyzer_bundle.pl example\sample-0-origin.html example\sample-1-evil-gemini.html make-everything-ok-button

```