module MojangApi
  class Profile
    include HTTParty
    base_uri "https://api.mojang.com"
    
    def initialize(params={})
      @name = params.fetch(:name, nil)
      @game = params.fetch(:game, 'minecraft')
      self.uuid = params.fetch(:uuid, nil)
      @uuid_time = params.fetch(:uuid_time, Time.now)
    end
    
    def uuid
      @uuid || load_uuid(@uuid_time)
    end
    
    def uuid=(new_uuid)
      new_uuid = new_uuid.strip.tr('-', '')
      raise "UUID is incorrect length." if new_uuid.length != 32
      @uuid = new_uuid
    end
    
    def dashed_uuid
      "#{uuid[0..7]}-#{uuid[8..11]}-#{uuid[12..15]}-#{uuid[16..19]}-#{uuid[20..31]}"
    end
    
    def name
      @name || load_name
    end
    
    def load_uuid(at = nil)
      opts = { format: :json }
      opts[:query] = { at: at.to_i } if at
      response = self.class.get("/users/profiles/#{@game}/#{@name}", opts)
      @uuid = response['id']
      @uuid_time = at.nil? ? Time.now : at
      @uuid
    end
    
    def load_name
      response = self.class.get("/user/profiles/#{@uuid}/names", format: :json)
      if response.ok? 
        if response.length > 1
          raise "Multiple names for that UUID, unknown behavior!" 
        end
        
      else
        raise "Unable to find that UUID."
      end
      @name = response[0]
      @name
    end
    
    def to_whitelist_format(version = :v17)
      {
        uuid: formatted_uuid,
        name: name
      }
    end
    
    class << self
      def load_from_name_list(usernames = [], game='minecraft')
        all_responses = []
        usernames = usernames.reject(&:empty?)
        usernames.uniq.each_slice(100) do |username_slice|
          opts = {
            body: username_slice.to_json,
            headers: {"Content-Type" => "application/json"}
          }
          response = post("/profiles/#{game}",opts)
          all_responses += response.map {|result| new(name: result['name'], uuid: result['id'], game: game)}
        end
        
        all_responses.sort_by! { |profile| profile.name }
      end
      
    end
    
  end
end