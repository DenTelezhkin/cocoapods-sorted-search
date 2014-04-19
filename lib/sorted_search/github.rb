require 'typhoeus'
require 'json'
require 'hashie'
require 'sorted_search/credentials'

module SortedSearch

  # Github API client
  #
  module GitHub

    HOSTNAME = "api.github.com"

    # returns Typhoeus::Request object, that can be added to Hydra
    # completion block will be called with parsed response, or nil if request failed
    def self.get_repo(owner, repo, &completion)
      token = SortedSearch::Credentials.token
      request = Typhoeus::Request.new("https://#{HOSTNAME}/repos/#{owner}/#{repo}", headers: { Authorization: "token #{token}" })
      request.on_complete(&self.parse_block(&completion))
      request
    end

    private

    def self.parse_block(&completion)
      lambda do |response|
        if response.success?
          parsed_body = JSON.parse response.body
          parsed_object = Hashie::Mash.new(parsed_body)
          completion.call(parsed_object) if completion
        else
          completion.call(nil)
        end
      end
    end

  end
end
