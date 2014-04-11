require File.expand_path('../../spec_helper', __FILE__)
require 'sorted_search/github'
require 'webmock/rspec'

module SortedSearch

  describe "fetch repo info" do
    before do
      stub_request(:get,"https://api.github.com/repos/foo/bar").
        to_return(body: fixture('dttableviewmanager.json'))
    end

    it "should receive github repo info" do
      request = SortedSearch::GitHub.repo('foo','bar')

      hydra = Typhoeus::Hydra.hydra
      hydra.queue request
      hydra.run

      repo = nil
      if request.response.success?
        repo = request.response.handled_response
      end

      repo.name.should eql('DTTableViewManager')
    end
  end

end