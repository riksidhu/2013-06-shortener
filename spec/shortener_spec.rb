# add files to load path
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "../"))
require 'shortener'
require 'rack/test'

def app
  Sinatra::Application
end

describe "URL Shortener" do
  include Rack::Test::Methods

  context "successful requests" do
    it "can shorten a link" do
      post '/new', :url => 'www.nyt.com' 
      last_response.status == 200
      last_response.body.should_not be_empty  
    end

    it "returns the same short-url for the same link" do
      url = 'www.google.com'
      post '/new', :url => url
      last_response.body.should_not be_empty
      short_link = last_response.body

      5.times do
        post '/new', :url => url
        last_response.body.should == short_link
      end
    end

    it "short-urls redirect correctly" do
      post '/new', :url => 'www.catalystclass.com'
      short_link = last_response.body

      get '/' + short_link.split('/')[1]
      last_response.should be_redirect 
      follow_redirect!
      last_request.url.should == 'http://www.catalystclass.com/'
    end
  end
  
  context "unsuccessful requests" do
    it "returns a 404 for a nonsense short-link" do
      get "/notacorrectlink"
      last_response.status.should == 404
    end
  end
end