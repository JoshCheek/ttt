module RestartAsSecond
  def mouse_clicked(event)
    Square.reset
    Square.computer_takes_turn
  end
end
