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
end

get '/' do
    'Welcome to Sinatra Shortener!'
end

post '/new' do
    # PUT CODE HERE TO CREATE NEW SHORTENED LINKS
end

####################################################
####  Implement Routes to make the specs pass ######
####################################################
