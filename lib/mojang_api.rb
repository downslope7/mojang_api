require "httparty"

require "mojang_api/version"
require "mojang_api/profile"
require "mojang_api/whitelist"

module MojangApi
  def self.get_profile_from_name(name, opts={})
    game = opts.fetch(:game, 'minecraft')
    uuid_time = opts.fetch(:at_time, Time.now)
    
    p = Profile.new name: name, uuid_time: uuid_time, game: game
    p.load_uuid
    p
  end
  
  def self.get_uuid_from_name(name, opts={})
    get_profile_from_name(name, opts).uuid
  end
  
  def self.get_profile_from_uuid(uuid, opts={})
    game = opts.fetch(:game, 'minecraft')
    
    p = Profile.new uuid: uuid, game: game
    p.load_name
    p
  end
  
  def self.get_name_from_uuid(uuid, opts={})
    get_profile_from_uuid(uuid, opts).name
  end
  
  def self.get_profiles_from_name_list(name_list)
    Profile.load_from_name_list(name_list)
  end
end
