module Pod
  module SortedSearch

    # base class for printers
    #
    class Printer
      def print(pods)
        raise Informative "Foo"
      end
    end

  end
end
