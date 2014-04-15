require File.expand_path('../../../../spec_helper', __FILE__)

# CocoaPods namespace
#
module Pod
  describe Command::Setup do

    describe "setup github" do

      it "registers itself" do
        expect(Command.parse(%w(setup github))).to be_instance_of(Command::Setup::GitHub)
      end

      it "presents the help if no name is provided" do
        command = Pod::Command.parse(['setup github'])
        expect { command.validate! }.to raise_error
      end

    end

  end

end
