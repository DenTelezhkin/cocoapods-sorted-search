CocoaPods sorted search
==============

CocoaPods plugin which adds a `sort` subcommand for `pod search` to sort search results by amount of stars, forks, or github activity. 

##Usage
  
    pod search sort POD_NAME
  
## Params

* **--stars** - sort by stars - **default**
* **--forks** - sort by forks
* **--activity** - sort by most recent commits
  
## Installation

    [sudo] gem install cocoapods-sorted-search
    
## Known issues

  Currently GitHub has a rate limit set for 60 API requests per hour. CocoaPods does great job at caching results, but it is easy to exceed current limit. Use with care =)
  
## Example

![](example.gif)
