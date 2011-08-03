require 'optparse'

require 'ttt/interface'

module TTT
  
  # The code for ttt/bin
  class Binary
    
    attr_accessor :filein, :fileout, :fileerr
    
    def initialize(argv, io={})
      self.fileout = io.fetch :fileout, $stdout
      self.fileerr = io.fetch :fileerr, $stderr
      self.filein  = io.fetch :filein,  $stdin
      parse argv
    end
    
    def parse(argv)
      argv = ['-h'] if argv.empty?
      Parser.new(self).parse argv
    rescue OptionParser::MissingArgument => e
      fileerr.puts e.message
      Kernel.exit 1
    end
    
    def has_interface?(interface_name)
      TTT::Interface.registered? interface_name
    end
    
    def list_of_registered
      TTT::Interface.registered_names.map(&:inspect).join(', ')
    end
    
    def interface(interface_name)
      TTT::Interface.registered[interface_name]
    end
    
    
    
    class Parser
      
      attr_accessor :binary
      
      def initialize(binary)
        self.binary = binary
      end
      
      def method_missing(meth, *args, &block)
        super unless binary.respond_to? meth
        binary.send meth, *args, &block
      end
            
      def parse(argv)
        options.parse argv
      end
      
      def options
        OptionParser.new do |options|
          define_banner     options
          define_interface  options
          define_help       options
        end
      end
    
      def options_for_interface
        return :filein => filein, :fileout => fileout, :fileerr => fileerr
      end
    
      def define_banner(options)
          options.banner = "Usage: ttt --interface interface_name\n" \
                           "ttt is an implementation of Tic Tac Toe by Josh Cheek\n\n"
      end
    
      def define_interface(options)
        options.on '-i', '--interface TYPE', "Specify which interface to play on. Select from: #{list_of_registered}" do |interface_name|
          if interface_name.equal? true
            fileerr.puts "Please supply interface type"
            Kernel.exit 1
          elsif has_interface? interface_name
            interface(interface_name).new(options_for_interface).play
          else
            fileerr.puts "#{interface_name.inspect} is not a valid interface, select from: #{list_of_registered}"
          end
        end
      end
    
      def define_help(options)
        options.on '-h', '--help', 'Display this screen' do
          fileout.puts options
        end
      end
    end
    
  end
end
