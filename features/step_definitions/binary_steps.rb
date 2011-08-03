Given /^I look at (.*)$/ do |location|
  @location = location
end

When /^I see it is executable$/ do
  File.executable?(@location).should be
end

Given /^I pass the it "([^"]*)" on the command line$/ do |args|
  require 'open3' # from stdlib
  binary = Class.new Struct.new(:exitstatus, :stdout, :stderr) do
    def initialize(args)
      Open3.popen3 "bin/ttt #{args}" do |stdin, stdout, stderr, wait_thr|
        super(wait_thr.value.exitstatus, stdout.read.strip, stderr.read.strip)
      end
    end
  end
  @binary = binary.new args
end

Then %r{^it should display /([^/]*)/$} do |message|
  Then "it should print /#{message}/ to stdout"
end

Then %r{^it should print /([^/]*)/ to (\w+)$} do |message, output_name|
  output = @binary.send output_name
  output.should match Regexp.new(message)
end

Then /^it should exit with code of (\d+)$/ do |code|
  @binary.exitstatus.should be code.to_i
end


# a simple greeting we'll have the CLI write
# just to make sure everything is hooked up correctly
Then /^it should welcome me to Tic Tac Toe$/ do
  Then "it should display /Welcome to Tic Tac Toe/"
end

