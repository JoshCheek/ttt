# got this idea from the RSpec Book
# modified it slightly
module IOStub
  
  class Output
    def messages
      @messages ||= []
    end
    def puts(message)
      messages << message
    end
    def see?(message)
      messages.include? message
    end
  end

  class Input
    def messages
      @messages ||= []
    end
    def <<(message)
      messages << message
    end
    def gets
      messages.shift
    end
  end
  
end


def stdout
  @stdout ||= Stub::Output.new
end

def stderr
  @stderr ||= Stub::Output.new
end

def stdin
  @stdin ||= Stub::Input.new
end
