require 'faraday'
require 'faraday_middleware'

module Cocoafind
  class GitHubApi
    HOSTNAME = 'api.github.com'

    def initialize
      @connection = Faraday.new "https://#{HOSTNAME}" do |builder|
        builder.adapter Faraday.default_adapter
        builder.response :mashify
        builder.response :json, :content_type => /\bjson$/
      end
    end

    def get_repository(owner,name)
      @connection.get("/repos/#{owner}/#{name}")
    end
  end

end