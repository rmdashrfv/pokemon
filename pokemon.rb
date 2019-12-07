require 'httparty'
require 'curb'
require 'json'
require 'securerandom'

class Pokemon
  # Every time the pokemon levels up, it will gain a small boost in stats in 2 areas
  # the stat boost should be 3% of whatever the stat currently is
  @@url = 'https://pokeapi.co/api/v2/'
  attr_accessor :name, :img_front, :img_back, :loaded
  attr_reader :id
  def initialize(name)
    @id = SecureRandom.hex(12)
    @name = name
    @hp = nil
    @atk = nil
    @defense = nil
    @sp_atk = nil
    @sp_def = nil
    @img_front = nil
    @img_back = nil
    @exp = 0
    @level = 1
    @loaded = false
    self.request_pokemon
  end
  
  def request_pokemon
    # req = Curl::Easy.perform(%(#{@@url}pokemon/#{@name.downcase}))
    # data = JSON.parse(req.body_str)
    req = HTTParty.get(%(#{@@url}pokemon/#{@name.downcase}))
    data = JSON.parse(req.body)
    stats = {
      hp: data['stats'][5]['base_stat'],
      atk: data['stats'][4]['base_stat'],
      defense: data['stats'][3]['base_stat'], 
      sp_atk: data['stats'][2]['base_stat'],
      sp_def: data['stats'][1]['base_stat']
    }
    @img_front = data['sprites']['front_default']
    @img_back = data['sprites']['back_default']
    @loaded = self.assign_stats(stats)
  end

  def assign_stats(s)
    @hp = s[:hp]
    @atk = s[:atk]
    @defense = s[:defense]
    @sp_atk = s[:sp_atk]
    @sp_def = s[:sp_def]
    return true
  end

  def serialize
    return {
    'id': @id, 'name': @name, 'atk': @atk, 'defense': @defense, 'sp_atk': @sp_atk, 'sp_def': @sp_def, 'level':@level, 'exp': @exp
    }.to_json
  end

  def sim_exp(n) # simulate rewarding EXP points
    @exp += n
    self.check_level(n)
  end

  def check_level(n)
    case @exp
    when (100..200)
      level = 1
    when (201..399)
      level = 2
    when (400..699)
      level = 3
    else
      level = 1
    end
    if level > @level
      @level = level
      puts %(#{@name} gained reached level #{level}!)
    else
      return %(#{@name} gained #{n} EXP)
    end
  end


  def save
    # whatever the state of the current instance
    # write that to the pokemon's file
    File.open(%(./public/gamedata/#{@name.downcase}_#{@id}.json), 'w') { |f|
      f.write(%(#{self.serialize}))
    } 
  end
 
end


# when you have created the pokemon, you should be able to save the pokemon permanently
# to your file system. The next time you open your browser, it would be able to load your
# pokemon
