require 'ruby-progressbar'

module Pod
  class Command
    class Search
      class Sorted < Search
        self.summary = 'Sort pod search results easily!'

        self.description = <<-DESC
          Sort CocoaPods search results by stars, forks, or repo activity.
        DESC

        self.command = "sort"

        def initialize(argv)
          super
          @sort_by_stars = argv.flag?('stars')
          @sort_by_commits = argv.flag?('activity')
          @sort_by_forks = argv.flag?('forks')
        end

        def self.options
          [
            ["--stars",   "Sort by stars"],
            ["--activity", "Sort by most recently changed repo"],
            ["--forks",   "Sort by amount of forks"]
          ].concat(super)
        end

        def run
          specs = find_specs(@query)
          fetch_github_info(specs)
          sorted_pods = sort_specs(specs)
          print_specs(sorted_pods)
        end

        def fetch_github_info(specs)
          found = "\nFound " + specs.count.to_s + " specs. Fetching GitHub info, wait a moment please.\n"
          UI.puts found.green

          progress_bar = ProgressBar.create(total: specs.count, length: 60)
          specs.each do |spec|
            pod = pod_from_spec(spec)
            pod.github_watchers # This will force statistics provider to fetch github info unless it is already cached
            progress_bar.increment
          end
        end

        def pod_from_spec(spec)
          statistics_provider = Config.instance.spec_statistics_provider
          Specification::Set::Presenter.new(spec, statistics_provider)
        end

        def print_specs(sorted_pods)
          sorted_pods.each do |pod|
            UI.title("-> #{pod.name} (#{pod.version})".green, '', 1) do
              next unless pod.github_last_activity
              stars = [0x2605].pack("U") + "  " + pod.github_watchers.to_s + " "
              forks = [0x2442].pack("U") + " " + pod.github_forks.to_s + " "
              commit = "Last commit: "+ pod.github_last_activity

              UI.puts_indented pod.summary
              UI.puts_indented stars.yellow + forks.yellow
              UI.puts_indented commit.yellow
            end

          end

          UI.puts

        end

        def sort_specs(specs)
          pods = specs.map { |spec| pod_from_spec(spec) }

          if @sort_by_stars
            return pods.sort  do |x,y|
              y.github_watchers.to_i <=> x.github_watchers.to_i
            end
          end

          if @sort_by_commits
            return pods.sort  do |x,y|
              y.statistics_provider.github_pushed_at(y.set).to_i <=> x.statistics_provider.github_pushed_at(x.set).to_i
            end
          end

          if @sort_by_forks
            return pods.sort  do |x,y|
              y.github_forks.to_i <=> x.github_forks.to_i
            end
          end
        end

        def find_specs(query)
          sets = SourcesManager.search_by_name(query.join(' ').strip, @full_text_search)
          if @supported_on_ios
            sets.reject!{ |set| !set.specification.available_platforms.map(&:name).include?(:ios) }
          end
          if @supported_on_osx
            sets.reject!{ |set| !set.specification.available_platforms.map(&:name).include?(:osx) }
          end

          sets
        end
      end
    end
  end
end