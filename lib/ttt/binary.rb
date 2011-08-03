require 'optparse'

require 'ttt/interface'

module TTT
  
  # The code for ttt/bin
  class Binary
    
    attr_accessor :stdout, :stderr, :stdin
    
    def initialize(argv, io={})
      self.stdout = io.fetch :out, $stdout
      self.stderr = io.fetch :err, $stderr
      self.stdin  = io.fetch :in,  $stdin
      parse argv
    end
    
    def parse(argv)
      argv = ['-h'] if argv.empty?
      options.parse argv
    rescue OptionParser::MissingArgument => e
      stderr.puts e.message
      Kernel.exit 1
    end
    
    def options
      OptionParser.new do |options|
        define_banner     options
        define_interface  options
        define_help       options
      end
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
    
    def options_for_interface
      return :in => stdin, :out => stdout, :err => stderr
    end
    
    def define_banner(options)
        options.banner = "Usage: ttt --interface interface_name\n" \
                         "ttt is an implementation of Tic Tac Toe by Josh Cheek\n\n"
    end
    
    def define_interface(options)
      options.on '-i', '--interface TYPE', "Specify which interface to play on. Select from: #{list_of_registered}" do |interface_name|
        if interface_name.equal? true
          stderr.puts "Please supply interface type"
          Kernel.exit 1
        elsif has_interface? interface_name
          interface(interface_name).new(options_for_interface).play
        else
          stderr.puts "#{interface_name.inspect} is not a valid interface, select from: #{list_of_registered}"
        end
      end
    end
    
    def define_help(options)
      options.on '-h', '--help', 'Display this screen' do
        stdout.puts options
      end
    end
    
  end
end
