require 'optparse'

module TTT
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
      optparse.parse! argv
    end
    
    def optparse
      OptionParser.new do |options|
        define_banner     options
        define_interface  options
        define_help       options
      end
    end
    
    def define_banner(options)
        options.banner = "Usage: ttt --interface interface_type\n" \
                         "ttt is an implementation of Tic Tac Toe by Josh Cheek\n\n"
    end
    
    def define_interface(options)
      options.on '-i', '--interface', "Specify which interface to play on. Select from" do |interface_name|
        stdout.p interface_name
      end
    end
    
    def define_help(options)
      options.on '-h', '--help', 'Display this screen' do
        stdout.puts options
      end
    end
    
  end
end
