require 'sorted_search/providers/provider'
require 'sorted_search/github'

module SortedSearch

  # base class for printers
  #
  class GithubProvider < Provider

    def fetch_data
      super
      pods = []
      @specs.each do |spec|
        pods << pod_from_spec(spec)
      end

      hydra = Typhoeus::Hydra.hydra

      @github_repos = {}
      pods.each do |pod|

        _, username, reponame = *(pod.source_url.match(%r{[:/]([\w\-]+)/([\w\-]+)\.git}))

        request = SortedSearch::GitHub.get_repo(username, reponame) do |response_object|
          @progress_bar.increment

          if response_object
            @github_repos[pod] = response_object
          else
            mash = Hashie::Mash.new
            mash.stargazers_count = 0
            mash.forks = 0
            mash.pushed_at = 0
            @github_repos[pod] = mash
          end
        end

        hydra.queue request
      end

      hydra.run
    end

    def sort_specs
      @github_repos.sort_by do |key, value|
        case @sorting_criteria

          when :stars
            value.stargazers_count.to_i

          when :forks
            value.forks.to_i

          when :activity
            value.pushed_at

          else
            nil
        end
      end.reverse!
    end
  end
end
