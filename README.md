[![Build Status](http://img.shields.io/travis/DenHeadless/cocoapods-sorted-search/master.svg)](https://travis-ci.org/DenHeadless/cocoapods-sorted-search)
[![Gem Version](http://img.shields.io/gem/v/cocoapods-sorted-search.svg)](http://badge.fury.io/rb/cocoapods-sorted-search)

CocoaPods sorted search
==============

CocoaPods plugin which adds a `sort` subcommand for `pod search` to sort search results by amount of stars, forks, or github activity. 

## Usage
  
    pod search sort POD_NAME
  
## Params

* **--stars** - sort by stars - **default**
* **--forks** - sort by forks
* **--activity** - sort by most recent commits
  
## Installation

    [sudo] gem install cocoapods-sorted-search
    
## Unleash the ~~hounds~~ pods!

  Plugin uses GitHub anonymous requests by default, that have rate limit of 60 requests per hour.
  
  Feed plugin with GitHub OAuth token, and raise the limit to **5000** requests per hour! Not only that, if provided with token, plugin starts to fetch GitHub info in parallel, making sorting incredibly fast. 
  
  Steps for token configuration:
  1. Go to GitHub settings -> Applications -> Personal Access Tokens
  2. Generate new one and **uncheck** all scopes. It should look [like this](https://raw.githubusercontent.com/DenHeadless/cocoapods-sorted-search/master/token_example.png).
  3. Run ``` pod setup github --token=MyToken ```

Your token will be stored in OS X Keychain and used automatically for fetching GitHub info for repositories.
  
## Example

![](example.gif)

## Requirements 

- CocoaPods 0.28 and higher
- Ruby 1.9.3 and higher

## Troubleshooting

First of, read [troubleshooting](https://github.com/DenHeadless/cocoapods-sorted-search/wiki/Troubleshooting) wiki page. If something still not right, post issue on GitHub to let me know!
