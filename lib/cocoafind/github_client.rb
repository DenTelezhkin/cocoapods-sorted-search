require 'faraday'
require 'faraday_middleware'
require 'typhoeus'
require 'typhoeus/adapters/faraday'

module Cocoafind
  class GitHubApi
    HOSTNAME = 'api.github.com'

    def initialize
      @connection = Faraday.new "https://#{HOSTNAME}" do |builder|
        builder.adapter :typhoeus
        builder.response :mashify
        builder.response :json
      end
    end

    def repository(owner,name)
      @connection.get("/repos/#{owner}/#{name}")
    end

    def repositories(list)
      repos = []
      @connection.in_parallel do
        list.each_slice(2) do |owner,repo|
          repos << repository(owner,repo)
        end
      end
      repos.map do |response|
        response.body
      end
    end
  end

end