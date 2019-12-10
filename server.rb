require 'sinatra'
require 'securerandom'
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
    @party << pokemon
    f.close
  }
  erb :team
end

post '/pokemon' do
  id = SecureRandom.hex(12)
  pokemon = Pokemon.new(id, params['pokemon_name'])
  pokemon.save
  pokemon.serialize
  redirect '/team'
end
