module MojangApi
  module Whitelist
    class Base
      attr_reader :profiles
      
      def initialize(profiles = [])
        @profiles = profiles
      end
      
      def load_from(filename)
        f = File.open(filename, "r")
        parse f
        f.close
        self
      end
      
      def save_to(filename)
        File.open(filename, "w") { |f| f.write(serialize) }
      end
      
      def to_version(version)
        case version
        when :v16
          OneSix.new(@profiles.dup)
        when :v17
          OneSeven.new(@profiles.dup)
        else
          raise "No such version!"
        end
      end
      
      class << self
        def load_from(filename)
          instance = new
          instance.load_from(filename)
          instance
        end
      end
      
      protected
      def parse(input)
        raise 'Not Implemented'
      end
      
      def serialize
        raise 'Not Implemented'
      end
      
    end
  end
end