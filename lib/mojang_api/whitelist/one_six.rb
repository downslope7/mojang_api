module MojangApi
  module Whitelist
    class OneSix < Base
      protected
      
      def parse(input)
        usernames = []
        input.each_line { |username| usernames << username.strip.downcase }
        pry binding
        @profiles = MojangApi.get_profiles_from_name_list(usernames.uniq)
      end
      
    end
  end
end
