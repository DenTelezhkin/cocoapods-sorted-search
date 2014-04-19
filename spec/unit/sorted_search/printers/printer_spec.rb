require File.expand_path('../../../../spec_helper', __FILE__)
require 'sorted_search/printers/printer'

#
module SortedSearch

  describe Printer do

    it "should raise if print method invoked" do
      printer = SortedSearch::Printer.new

      expect { printer.print([]) }.to raise_exception
    end

  end

end
