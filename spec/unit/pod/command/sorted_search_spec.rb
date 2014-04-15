require File.expand_path('../../../../spec_helper', __FILE__)
# CocoaPods namespace
#
module Pod
  describe Command::Search do

    describe "sort" do

      it "registers itself" do
        expect(Command.parse(%w(search sort))).to be_instance_of(Command::Search::Sorted)
      end

    end

  end

end
