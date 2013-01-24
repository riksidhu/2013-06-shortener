namespace :db do
   task :environment do
     require 'active_record'
     ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database =>  'db/test.sqlite3.db'
   end
 
   desc "Migrate the database"
   task(:migrate => :environment) do
     ActiveRecord::Migration.verbose = true
     ActiveRecord::Migrator.migrate("db/migrate")
   end
end