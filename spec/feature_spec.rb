require './lib/oystercard'

card = Oystercard.new

card.top_up(10)

card.touch_in(:bank)
card.touch_out(:water)

card.touch_in(:street)
card.touch_out(:water)

puts "card #{card.inspect}"
