require 'typhoeus'
require 'json'
require 'hashie'

module SortedSearch
  module GitHub

    HOSTNAME = "api.github.com"

    # returns Typhoeus::Request object, that can be added to Hydra
    def self.repo(owner,repo)
      request = Typhoeus::Request.new("https://#{HOSTNAME}/repos/#{owner}/#{repo}")
      request.on_complete(&self.parse_block)
      request
    end

    def self.parse_block
      lambda do |response|
        if response.success?
          parsed_body = JSON.parse response.body
          parsed_object = Hashie::Mash.new(parsed_body)
          parsed_object
        else
          nil
        end
      end
    end

  end
end