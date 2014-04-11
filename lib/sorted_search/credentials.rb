require 'osx_keychain'

module SortedSearch
  module Credentials

    GITHUB_TOKEN_KEY = "GitHub token key"

    def self.token
      keychain = OSXKeychain.new
      keychain["GitHub CocoaPods sorted search",GITHUB_TOKEN_KEY]
    end

    def self.token=(token)
      keychain = OSXKeychain.new
      keychain["GitHub CocoaPods sorted search",GITHUB_TOKEN_KEY] = token
    end

  end
end