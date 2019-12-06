require 'sinatra'
require './pokemon.rb'
set :port, 3000

get '/' do
  erb :index
end


post '/pokemon' do
  puts params
  pokemon = Pokemon.new(params['pokemon_name'])
  pokemon.save
  return pokemon.serialize
end
