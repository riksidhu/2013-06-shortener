require 'sinatra'
require "sinatra/reloader" if development?
require 'active_record'
require 'pry'

configure :development, :production do
    ActiveRecord::Base.establish_connection(
       :adapter => 'sqlite3',
       :database =>  'db/dev.sqlite3.db'
     )
end

# Quick and dirty form for testing application
#
# If building a real application you should probably
# use views: 
# http://www.sinatrarb.com/intro#Views%20/%20Templates
form = <<-eos
    <form id='myForm'>
        <input type='text' name="url">
        <input type="submit" value="Shorten"> 
    </form>
    <h2>Results:</h2>
    <h3 id="display"></h3>
    <script src="jquery.js"></script>

    <script type="text/javascript">
        $(function() {
            $('#myForm').submit(function() {
            $.post('/new', $("#myForm").serialize(), function(data){
                $('#display').html(data);
                });
            return false;
            });
    });
    </script>
eos

# Models to Access the database 
# through ActiveRecord.  Define 
# associations here if need be
#
# http://guides.rubyonrails.org/association_basics.html
class Link < ActiveRecord::Base
end

get '/' do
    form
end

post '/new' do
    # PUT CODE HERE TO CREATE NEW SHORTENED LINKS
    def make_token
      ("%d%d" % [rand(100), Time.now.to_i]).to_i.to_s(36)
    end

    short_url = make_token

    @link = Link.create(fullurl: @params['url'], shorturl: short_url)
    '<a href="http://localhost:4567/r/'+short_url+'">http://localhost:4567/r/'+short_url+'</a>'
end

get '/jquery.js' do
    send_file 'jquery.js'
end

####################################################
####  Implement Routes to make the specs pass ######
####################################################

get '/r/:url' do
  @lookup = Link.find_by_shorturl(@params[:url])
  redirect @lookup.fullurl
end



















