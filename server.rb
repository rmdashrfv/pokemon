require 'sinatra'
require './pokemon.rb'
set :port, 3000

get '/' do
  erb :index
end

get '/pokemon/:id' do
  id = params[:id]
  file = File.open(%(./public/gamedata/#{id}.json), 'r')
  @pokemon = Pokemon.load(file.read)
  erb :pokemon
end

get '/team' do
  path = './public/gamedata/'
  @party = []
  Dir.foreach('./public/gamedata/') { |file|
    f = File.open(path + file, 'r')
    next if File.directory?(f)
    pokemon = Pokemon.load(f.read)
    p pokemon
    @party << pokemon
    f.close
  }
  erb :team
end

post '/pokemon' do
  puts params
  pokemon = Pokemon.new(params['pokemon_name'])
  pokemon.save
  return pokemon.serialize
end
