require 'osx_keychain'

module SortedSearch

  # Module for saving github token to Mac OS X keychain
  #
  module Credentials

    GITHUB_TOKEN_KEY = "GitHub token key"

    def self.token
      keychain = OSXKeychain.new
      keychain["GitHub CocoaPods OAuth token", GITHUB_TOKEN_KEY]
    end

    def self.token=(token)
      keychain = OSXKeychain.new
      keychain["GitHub CocoaPods OAuth token", GITHUB_TOKEN_KEY] = token
    end

  end
end
