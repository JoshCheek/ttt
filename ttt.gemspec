# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ttt}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Joshua J Cheek}]
  s.date = %q{2011-08-04}
  s.description = %q{TTT is a Tic Tac Toe lib, as well as a CLI and GUI to play it.}
  s.email = %q{josh.cheek@gmail.com}
  s.executables = [%q{ttt}]
  s.files = [%q{Gemfile}, %q{Gemfile.lock}, %q{MIT-License.md}, %q{Rakefile}, %q{Readme.md}, %q{bin/ttt}, %q{spec/spec_helper.rb}, %q{spec/ttt}, %q{spec/ttt/computer_player_spec.rb}, %q{spec/ttt/game_spec.rb}, %q{spec/ttt/rating_spec.rb}, %q{features/binary.feature}, %q{features/computer_player.feature}, %q{features/create_game.feature}, %q{features/finish_game.feature}, %q{features/finished_states.feature}, %q{features/mark_board.feature}, %q{features/step_definitions}, %q{features/step_definitions/binary_steps.rb}, %q{features/step_definitions/ttt_steps.rb}, %q{features/support}, %q{features/support/env.rb}, %q{features/view_board_as_developer.feature}, %q{features/view_board_as_tester.feature}, %q{lib/ttt}, %q{lib/ttt/binary.rb}, %q{lib/ttt/computer_player.rb}, %q{lib/ttt/game.rb}, %q{lib/ttt/interface}, %q{lib/ttt/interface/cli}, %q{lib/ttt/interface/cli/players.rb}, %q{lib/ttt/interface/cli/views.rb}, %q{lib/ttt/interface/cli.rb}, %q{lib/ttt/interface/limelight}, %q{lib/ttt/interface/limelight/players}, %q{lib/ttt/interface/limelight/players/restart_as_first.rb}, %q{lib/ttt/interface/limelight/players/restart_as_second.rb}, %q{lib/ttt/interface/limelight/players/square.rb}, %q{lib/ttt/interface/limelight/props.rb}, %q{lib/ttt/interface/limelight/styles.rb}, %q{lib/ttt/interface/limelight.rb}, %q{lib/ttt/interface.rb}, %q{lib/ttt/ratings.rb}, %q{lib/ttt.rb}]
  s.homepage = %q{https://github.com/JoshCheek/ttt}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6.1}
  s.summary = %q{Tic Tac Toe lib + binary}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler-bouncer>, ["~> 0.1.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_development_dependency(%q<cucumber>, ["~> 1.0.2"])
      s.add_development_dependency(%q<pry>, ["~> 0.9.3"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
    else
      s.add_dependency(%q<bundler-bouncer>, ["~> 0.1.2"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_dependency(%q<cucumber>, ["~> 1.0.2"])
      s.add_dependency(%q<pry>, ["~> 0.9.3"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
    end
  else
    s.add_dependency(%q<bundler-bouncer>, ["~> 0.1.2"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    s.add_dependency(%q<cucumber>, ["~> 1.0.2"])
    s.add_dependency(%q<pry>, ["~> 0.9.3"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
  end
end
