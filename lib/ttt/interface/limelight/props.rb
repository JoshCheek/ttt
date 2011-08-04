__ :name => 'tic_tac_toe'

controls do
  restart_as_first  :text => 'Restart as first player', :id => 'restart_first'
  restart_as_second :text => 'Restart as second player', :id => 'restart_second'
end

squares do
  (1..9).each { |n| square :id => "square#{n}", :styles => "square#{n}" }
end
