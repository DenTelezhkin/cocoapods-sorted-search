require File.expand_path('../../../../spec_helper', __FILE__)
# CocoaPods namespace
#
module Pod

  describe "command" do

    it "registers itself" do
      expect(Command.parse(%w(search sort))).to be_instance_of(Command::Search::Sorted)
    end

    it "should correctly set stars sort order" do
      command = Command.parse(%w(search sort))
      expect(command.sorting_criteria).to equal(:stars)
    end

    it "should correctly set stars sort order" do
      command = Command.parse(%w(search sort --stars))
      expect(command.sorting_criteria).to equal(:stars)
    end

    it "should correctly set stars sort order" do
      command = Command.parse(%w(search sort --forks))
      expect(command.sorting_criteria).to equal(:forks)
    end

    it "should correctly set stars sort order" do
      command = Command.parse(%w(search sort --activity))
      expect(command.sorting_criteria).to equal(:activity)
    end

    it "should correctly set stars sort order" do
      command = Command.parse(%w(search sort --stars --forks --activity))
      expect(command.sorting_criteria).to equal(:stars)
    end

  end

end
