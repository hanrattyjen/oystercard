require './lib/oystercard'
require './lib/journey'

card = Oystercard.new

card.top_up(10)
#
# card.touch_in(:bank)
# card.touch_out(nil)
#
# card.touch_in(nil)
# card.touch_out(:water)

puts "card #{card.inspect}"
