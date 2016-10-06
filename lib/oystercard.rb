require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station
  attr_accessor :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(balance = 0, journey = Journey.new)
    @balance = balance
    @journey = journey
  end

  def top_up(amount)
    fail "Maximum balance exceeded. Maximum balance allowed is #{MAXIMUM_BALANCE}" if amount > (MAXIMUM_BALANCE - balance)
    @balance += amount
  end

  def touch_in(station_name)
    fail "Insufficient funds to travel" if @balance < MINIMUM_FARE
    journey.in_journey == true ? deduct(fare) : journey.start(station_name)
  end

  def touch_out(station_name)
    journey.end(station_name)
    deduct(fare)
    journey.record_journey
  end

  def fare
    journey.incomplete_journey? ? PENALTY_FARE : MINIMUM_FARE
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
