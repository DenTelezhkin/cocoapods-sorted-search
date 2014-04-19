require 'sorted_search/providers/provider'

module SortedSearch

  # base class for printers
  #
  class CocoapodsProvider < Provider

    def fetch_data
      super
      @specs.each do |spec|
        pod = pod_from_spec(spec)
        puts pod.source_url
        pod.github_watchers # This will force statistics provider to fetch github info unless it is already cached
        @progress_bar.increment
      end
    end

    def sort_specs
      pods = @specs.map { |spec| pod_from_spec(spec) }

      pods.sort do |x, y|
        case @sorting_criteria

          when :stars
            y.github_watchers.to_i <=> x.github_watchers.to_i

          when :forks
            y.github_forks.to_i <=> x.github_forks.to_i

          when :activity
            y.statistics_provider.github_pushed_at(y.set).to_i <=> x.statistics_provider.github_pushed_at(x.set).to_i
          else
            nil
          end
      end
    end
  end
end
