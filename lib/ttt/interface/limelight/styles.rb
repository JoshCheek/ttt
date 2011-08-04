tic_tac_toe {
  background_color :white
  padding 10
}

controls {
  height '20%'
}

restarters {
  width   170
  height  '100%'
  text_color :white
  font_size 20
  vertical_alignment :center
  horizontal_alignment :center
  background_color :gray
  rounded_corner_radius 10
  top_margin 20
  bottom_margin 20
}

restart_as_first {
  extends :restarters
  left_margin 20
  right_margin 10
}

restart_as_second {
  extends :restarters
  left_margin 10
  right_margin 20
}

squares {
  width 340
  background_color :green
}

square {
  width 100
  height 100
  background_color :white
  text_color :black
  font_size 40
  vertical_alignment :center
  horizontal_alignment :center
  border_color :black
}

left_of_another_square { 
  width 120
  right_border_width 20
}
above_another_square {  
  height 120
  bottom_border_width 20 
}
square1 {
  extends :left_of_another_square
  extends :above_another_square
  extends :square
}
square2 {
  extends :left_of_another_square
  extends :above_another_square
  extends :square
}
square3 {
  extends :above_another_square
  extends :square
}

square4 {
  extends :left_of_another_square
  extends :above_another_square
  extends :square
}
square5 {
  extends :left_of_another_square
  extends :above_another_square
  extends :square
}
square6 {
  extends :above_another_square
  extends :square
}

square7 {
  extends :left_of_another_square
  extends :square
}
square8 {
  extends :left_of_another_square
  extends :square
}
square9 {
  extends :square
}
