require File.expand_path('../../spec_helper', __FILE__)
require 'sorted_search/github'
require 'webmock/rspec'
require 'sorted_search/credentials'

# Sorted Search Github API fetcher tests
#
module SortedSearch
  #
  module Github
    describe "fetch repo info" do
      before do
        stub_request(:get, "https://api.github.com/repos/foo/bar")
        .with(headers: { Authorization: "token foo" })
        .to_return(body: fixture('dttableviewmanager.json'))
      end

      it "should receive github repo info" do
        allow(SortedSearch::Credentials).to receive(:token).and_return("foo")

        request = SortedSearch::GitHub.repo('foo', 'bar')
        request.run

        repo = nil
        if request.response.success?
          repo = request.response.handled_response
        end

        repo.name.should eql('DTTableViewManager')
      end
    end
  end
end
