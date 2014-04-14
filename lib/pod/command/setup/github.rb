require 'ruby-progressbar'
require 'cocoapods'

module Pod
  class Command
    class Setup

      # The pod search sort subcommand
      #
      class GitHub < Setup
        self.summary = 'Sort pod search results easily!'

        self.description = <<-DESC
          Add GitHub token to use authenticated requests for pod search sort command.
          Send up to 1000 requests per hour!
        DESC

        self.command = "github"

        def initialize(argv)
          super
          @token = argv.option('token')
        end

        def self.options
          [
            ["--token", "GitHub OAuth token"],
          ]
        end

        def validate!
          super
          help! "GitHub token is required" unless @token
        end

        def run
          puts @token
        end
      end
    end
  end
end
