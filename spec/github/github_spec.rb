# encoding: UTF-8
require 'spec_helper'
require 'webmock'
require 'webmock/rspec'

describe Cocoafind::GitHubApi do
  before do
    @client = Cocoafind::GitHubApi.new
  end

  describe "repository" do
    before do
      stub_request(:get,"https://api.github.com/repos/foo/bar").
          to_return(body: File.new(File.dirname(__FILE__) + "/../fixtures/dttableviewmanager.json"))
    end

    it "should return repository" do
      repo = @client.repository("foo","bar")
      repo.body.name.should eql("DTTableViewManager")
    end
  end
end