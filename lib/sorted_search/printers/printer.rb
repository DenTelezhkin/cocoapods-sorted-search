module Pod
  module SortedSearch

    # base class for printers
    #
    class Printer
      def print(pods)
        raise Informative "Redefine print method in subclasses"
      end
    end

  end
end
