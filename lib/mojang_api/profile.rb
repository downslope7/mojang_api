module MojangApi
  class Profile
    include HTTParty
    base_uri "https://api.mojang.com"
    
    def initialize(params={})
      @name = params.fetch(:name, nil)
      @game = params.fetch(:game, 'minecraft')
      @uuid = params.fetch(:uuid, nil)
      @uuid_time = params.fetch(:uuid_time, Time.now)
    end
    
    def uuid
      @uuid || load_uuid(@uuid_time)
    end
    
    def name
      @name || load_name
    end
    
    def load_uuid(at = nil)
      opts = {}
      opts[:query] = { at: at.to_i } if at
      response = self.class.get("/users/profiles/#{@game}/#{@name}", opts)
      @uuid = response['id']
      @uuid_time = at.nil? ? Time.now : at
      @uuid
    end
    
    def load_name
      response = self.class.get("/user/profiles/#{@uuid}/names")
      raise "Multiple names for that UUID, unknown behavior!" if response.length > 1
      @name = response[0]
      @name
    end
    
    def to_whitelist_format(version = :v17)
      {
        uuid: uuid,
        name: name
      }
    end
    
    class << self
      def load_from_name_list(usernames = [], game='minecraft')
        opts = {
          body: usernames.to_json,
          headers: {"Content-Type" => "application/json"}
        }
        response = post("/profiles/#{game}",opts)
        response.map {|result| new(name: result['name'], uuid: result['id'], game: game)}
      end
      
    end
    
  end
end