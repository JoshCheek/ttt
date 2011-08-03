# got this idea from the RSpec Book
# modified it slightly
module IOStub
  
  class Output
    def messages
      @messages ||= []
    end
    def puts(message)
      message.to_s.split("\n").each { |line| messages << line }
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
  @stdout ||= IOStub::Output.new
end

def stderr
  @stderr ||= IOStub::Output.new
end

def stdin
  @stdin ||= IOStub::Input.new
end
