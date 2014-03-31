require 'faraday'
require 'faraday_middleware'

module Cocoafind
  class GitHubApi
    HOSTNAME = 'api.github.com'

    def initialize
      @connection = Faraday.new "https://#{HOSTNAME}" do |builder|
        builder.response :json, :content_type => /\bjson$/
        builder.adapter Faraday.default_adapter
      end
    end

    def get_repository(owner,name)
      @connection.get("/repos/#{owner}/#{name}")
    end
  end

end