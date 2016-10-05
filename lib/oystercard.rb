require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station
  attr_accessor :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
    @touch_in = false
  end

  def top_up(amount)
    fail "Card limit of £#{MAXIMUM_BALANCE} has been reached." if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient funds" if @balance < MINIMUM_BALANCE
    if @touch_in == true then deduct(PENALTY_FARE) end
    @journey = Journey.new(entry_station)
    @touch_in = true
    @journey.in_journey?
  end

  def touch_out(exit_station)
    if @touch_in == false
       @journey = Journey.new(exit_station)
       deduct(PENALTY_FARE)
    end
    @journey.exit_station = exit_station
    add_to_array
    deduct(MINIMUM_FARE)
    reset_touch_in
    @journey.in_journey?
  end

  private

  def reset_touch_in
    @touch_in = false
  end


  def add_to_array
    @journey.add_journey
    @journeys << @journey.journey
  end

  def deduct(amount)
    @balance -= amount
  end

end
