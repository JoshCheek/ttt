Given /^I look at (.*)$/ do |location|
  @location = location
end

When /^I see it is executable$/ do
  executable = File.executable?(@location)
  executable.should be
end

Given /^I pass the it "([^"]*)" on the command line$/ do |args|
  # in, out, and err are defined in features/support/io_stub
  @binary = TTT::Binary.new args.split, :in => stdin, :out => stdout, :err => stderr
end

Then /^it should display "([^"]*)"$/ do |message|
  stdout.messages.should include message
end

Then /^it should print "([^"]*)" to (\w+)$/ do |message, output_name|
  output = send output_name
  output.messages.should include message
end

Then /^it should exit with code of (\d+)$/ do |code|
  Kernel.should_receive(:exit).once.with(code.to_i)
end

Then /^it should create a (\w+) interface$/ do |interface_name|
  @interface = stub
  interface_class = TTT::Interface.const_get interface_name
  interface_class.should_receive(:new).once.and_return(stub)
end

Then /^it should tell the interface to play the game$/ do
  @interface.should_receive(:play)
end
