# run me with 'bundle exec shotgun shortener.rb' 
# to enable autoreloading of the server when file 
# changes are saved.

require 'sinatra'
require 'active_record'

# Models to Access the database 
# through ActiveRecord.  Define 
# associations here if need be
#
# http://guides.rubyonrails.org/association_basics.html
class Link < ActiveRecord::Base
end

get '/' do
    "Welcome to Sinatra Shortener!"
end

post '/new' do
    # PUT CODE HERE TO CREATE NEW SHORTENED LINKS
end

####################################################
####  Implement Routes to make the specs pass ######
####################################################

