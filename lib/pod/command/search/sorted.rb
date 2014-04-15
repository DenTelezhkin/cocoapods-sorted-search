require 'ruby-progressbar'
require 'cocoapods'
require 'sorted_search/printers/pods_printer'

module Pod
  class Command
    class Search

      # The pod search sort subcommand
      #
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

          if !@sort_by_forks && !@sort_by_commits
            @sort_by_stars = true
          end

          @printer_klass = SortedSearch::PodPrinter
        end

        def self.options
          [
            ["--stars",   "Sort by stars"],
            ["--activity", "Sort by most recently changed repo"],
            ["--forks",   "Sort by amount of forks"],
          ].concat(super)
        end

        def run
          specs = find_specs(@query)
          fetch_github_info(specs)
          sorted_pods = sort_specs(specs)

          printer = @printer_klass.new
          printer.print(sorted_pods)
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

        def sort_specs(specs)
          pods = specs.map { |spec| pod_from_spec(spec) }

          if @sort_by_stars
            return pods.sort  do |x, y|
              y.github_watchers.to_i <=> x.github_watchers.to_i
            end
          end

          if @sort_by_commits
            return pods.sort  do |x, y|
              y.statistics_provider.github_pushed_at(y.set).to_i <=> x.statistics_provider.github_pushed_at(x.set).to_i
            end
          end

          if @sort_by_forks
            return pods.sort  do |x, y|
              y.github_forks.to_i <=> x.github_forks.to_i
            end
          end
        end

        def find_specs(query)
          sets = SourcesManager.search_by_name(query.join(' ').strip, @full_text_search)
          if @supported_on_ios
            sets.reject! { |set| !set.specification.available_platforms.map(&:name).include?(:ios) }
          end
          if @supported_on_osx
            sets.reject! { |set| !set.specification.available_platforms.map(&:name).include?(:osx) }
          end

          sets
        end
      end
    end
  end
end
