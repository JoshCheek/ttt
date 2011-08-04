module TTT
  module Interface
    def self.registered
      @registered_interfaces ||= Hash.new
    end
    
    def self.registered?(name)
      registered.has_key? name
    end
    
    def self.registered_names
      registered.keys
    end
    
    def self.register(name, interface)
      registered[name] = interface
    end
  end
end

require 'ttt/interface/cli'
require 'ttt/interface/limelight'
