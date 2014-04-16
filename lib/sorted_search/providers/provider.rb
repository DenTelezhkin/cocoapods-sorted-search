require 'ruby-progressbar'

module Pod
  module SortedSearch

    # base class for printers
    #
    class Provider

      def initialize(specs, sorting_criteria)
        @specs = specs
        @sorting_criteria = sorting_criteria
      end

      def provide_sorted_specs
        fetch_data
        sort_specs
      end

      # private

      def fetch_data
        found = "\nFound " + @specs.count.to_s + " specs. Fetching GitHub info, wait a moment please.\n"
        UI.puts found.green

        @progress_bar = ProgressBar.create(total: @specs.count, length: 60)
      end

      def sort_specs
      end

      def pod_from_spec(spec)
        statistics_provider = Config.instance.spec_statistics_provider
        Specification::Set::Presenter.new(spec, statistics_provider)
      end
    end

  end
end
