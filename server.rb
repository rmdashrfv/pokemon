require 'sinatra'
require './pokemon.rb'
set :port, 3000

get '/' do
  erb :index
end

get '/pokemon/:id' do
  file = File.open(%(_#{params[:id]}), 'r')
  if file
    puts "Found a pokemon!"
  else
    puts "404 POKEMON NOT FOUND"
  end
end

get '/team' do
  f = File.open('./public/gamedata/blaziken_19009bae0c05ccc26c16b1e0.json', 'r')
  data = JSON.parse f.read
  @pokemon = data
  erb :team
end

post '/pokemon' do
  puts params
  pokemon = Pokemon.new(params['pokemon_name'])
  pokemon.save
  return pokemon.serialize
end
