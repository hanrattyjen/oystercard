require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station
  attr_accessor :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    fail "Card limit of £#{MAXIMUM_BALANCE} has been reached." if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient funds" if @balance < MINIMUM_BALANCE
    @journey = Journey.new(entry_station)
    @journey.in_journey?
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journey.exit_station = exit_station
    @journey.add_journey
    @journeys << @journey.journey
    @journey.in_journey?
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
