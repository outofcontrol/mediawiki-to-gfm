# Mediawiki to GitHub Flavoured Markdown

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/outofcontrol/mediawiki-to-gfm.svg?branch=master)](https://travis-ci.org/outofcontrol/mediawiki-to-gfm)

Mediawiki to GFM is a script to convert a set of [Mediawiki](https://www.mediawiki.org)
pages to [GitHub Flavoured Markdown](https://github.github.com/gfm/) (GFM). This script was written from a necessity to convert a MediaWiki installation to a GitLab wiki. This code is based on [MediaWiki to Markdown](https://github.com/philipashlock/mediawiki-to-markdown) by [Philip Ashlock](https://github.com/philipashlock/). Philip graciously gave us permission to post our version as a new project.

Major differences include the addition of PHPUnit tests, code is broken into classes, deprecated code removed, work around for a bug in Pandoc added, fix for a common MediaWiki user error added, other small changes other small changes. 

## Requirements

* PHP: Tested in PHP 7.0, 7.1, 7.2 and 8.0
* Pandoc: Installation instructions are here https://pandoc.org/installing.html
    - Tested on version 2.0.1.1 and 2.0.2 
* MediaWiki: https://www.mediawiki.org/wiki/MediaWiki
    - Tested on version 1.27.x and 1.29.x
* Composer: Installation instructions are here https://getcomposer.org/download/

## Installation 

    git clone https://github.com/outofcontrol/mediawiki-to-gfm.git
    cd mediawiki-to-gfm
    composer update --no-dev
    
## Run

Run the script on your exported MediaWiki XML file:

    ./convert.php --filename=/path/to/filename.xml --output=/path/to/converted/files 

## Options

    ./convert.php --filename=/path/to/filename.xml --output=/path/to/converted/files --format=gfm --addmeta --flatten --indexes

    --filename : Location of the mediawiki exported XML file to convert 
                 to GFM format (Required)
    --output   : Location where you would like to save the converted files
                 (Default: ./output)
    --format   : What format would you like to convert to. Default is GFM 
                 (for use in GitLab and GitHub) See pandoc documentation
                 for more formats (Default: 'gfm')
    --addmeta  : This flag will add a Permalink to each file (Default: false)
    --flatten  : This flag will force all pages to be saved in a single level 
                 directory. File names will be converted in the following way:
                 Mediawiki_folder/My_File_Name -> Mediawiki_folder_My_File_Name
                 and saved in a file called 'Mediawiki_folder_My_File_Name.md' 
                 (Default: false)
    --help     : This help message (almost)

## Run with docker

Create a new directory and put `filename.xml` into the new directory:
```bash
mkdir my_wiki
mv filename.xml my_wiki/
cd my_wiki
```
Now you can convert `filename.xml` using docker.
Note: do **not** use the output parameter. The output will always be written into the subdirectory `output` of the current path. (hence the creation of a new directory). This is necessary, because the docker container does not have access to your filesystem except for the current directory (because of the `-v $PWD:/app` parameter for docker)
```bash
docker run -v $PWD:/app thawn/mediawiki-to-gfm --filename=filename.xml
```

## Export Mediawiki Files to XML 

In order to convert from MediaWiki format to GFM and use in GitLab (or GitHub), you will first need to export all the pages you wish to convert from Mediawiki into an XML file. Here are a few simple steps to help
you accomplish this quickly:

1. MediaWiki -> Special Pages -> 'All Pages'
1. With help from the filter tool at the top of 'All Pages', copy the page names to convert into a text file (one file name per line).
1. MediaWiki -> Special Pages -> 'Export'
1. Paste the list of pages into the Export field. 
1. Check: 'Include only the current revision, not the full history'  
   Note: This convert script will only do latest version, not revisions. 
1. Uncheck: Include Templates
1. Check: Save as file
1. Click on the 'Export' button.
1. An XML file will be saved locally. 
1. Use this convert.php script to convert the XML file a set of GFM formatted pages. 

In theory you can convert to any of these formats… (not tested):  
    https://pandoc.org/MANUAL.html#description

Updates and improvements are welcome! Please only submit a PR if you have also written tests and tested your code! To run phpunit tests, update composer without the --no-dev parameter:

    composer update

## Thank you

[@mloskot](https://github.com/mloskot/): Verify that this script does run in PHP 7.2 ([#1](https://github.com/outofcontrol/mediawiki-to-gfm/issues/1))  
[@timwsuqld](https://github.com/timwsuqld/): First contribution!

## Disclaimer

This script has not been tested on Windows. 
