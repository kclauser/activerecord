require 'sqlite3'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: File.dirname(__FILE__) + "/webdictionary.db"
)

Tilt.register Tilt::ERBTemplate, 'html.erb'

class Definition < ActiveRecord::Base
  :word
  :meaning
end

get '/' do

  erb :index
end

get '/add' do
  erb :add
end

post '/save' do

  word = params["word"]
  definition = params["definition"]
  new_entry = Definition.create(word: word, meaning: definition)

  redirect to '/'
end

post '/search' do
  
  search_result = Definition.find_by(word: params["searchword"])
  @definition_found = "#{search_result.word} - #{search_result.meaning}"

  erb :search
end
