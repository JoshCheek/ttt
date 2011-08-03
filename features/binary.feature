Feature: Binary
  In order to interact with the interfaces
  As a player
  I want a binary where I can specify how I should be able to interact

  Scenario: It is a binary
    Given I look at bin/ttt
    Then I see it is executable
  
  Scenario: -h
    Given I pass the it "-h" on the command line
    Then it should display /^Usage/
  
  Scenario: --help
    Given I pass the it "--help" on the command line
    Then it should display /^Usage/
  
  Scenario: no input displays help
    Given I pass the it "" on the command line
    Then it should display /^Usage/

  Scenario: -i without an arg
    Given I pass the it "-i" on the command line
    Then it should print /missing argument: -i/ to stderr
    And it should exit with code of 1
    

  Scenario: --interface, without an arg
    Given I pass the it "--interface" on the command line
    Then it should print /missing argument: --interface/ to stderr
    And it should exit with code of 1

  Scenario: -i cli
    Given I pass the it "-i cli" on the command line
    Then it should welcome me to Tic Tac Toe

  Scenario: -i not_real_interface
    Given I pass the it "-i not_real_interface" on the command line
    Then it should print /"not_real_interface" is not a valid interface/ to stderr
