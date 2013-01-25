require 'sinatra'
require "sinatra/reloader" if development?
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(
   :adapter => 'sqlite3',
   :database =>  'db/test.sqlite3.db'
 )

# Models to Access the database 
# through ActiveRecord.  Define 
# associations here if need be
#
# http://guides.rubyonrails.org/association_basics.html
class Link < ActiveRecord::Base
    attr_accessible :url, :short
end

get '/' do
    'Welcome to Sinatra Shortener!'
end

post '/new' do
    url = params[:url]
    link = Link.find_by_url(url)
    unless link
        shortened = Link.create({:url => url})
        shortened.short = shortened.id.to_s(36)
        shortened.save
        link = shortened
    end

    "#{request.host_with_port}/#{link.short}"
    # PUT CODE HERE TO CREATE NEW SHORTENED LINKS
end

####################################################
####  Implement Routes to make the specs pass ######
####################################################

get '/:short' do
    link = Link.find_by_short(params[:short])
    pass unless link

    redirect 'http://' + link.url
end
