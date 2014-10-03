
module MojangApi
  module Whitelist
    class OneSeven < Base
      protected
      
      def parse(input)
        json = JSON.load(input)
        @profiles = json.map {|j| MojangApi.get_profile_from_uuid(j['uuid']) }
      end
      
    end
  end
end
