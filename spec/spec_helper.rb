require 'bundler/bouncer'
require 'ttt'

def enumerator
  if RUBY_VERSION == '1.8.7'
    Enumerable::Enumerator
  else
    Enumerator
  end
end
