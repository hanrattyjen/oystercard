require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  attr_reader :balance, :entry_station, :journey_log
  attr_accessor :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6


  def initialize(balance = 0, journey = Journey.new, journey_log = JourneyLog.new  )
    @balance = balance
    @journey = journey
    @journey_log = journey_log
  end

  def top_up(amount)
    fail "Maximum balance exceeded. Maximum balance allowed is #{MAXIMUM_BALANCE}" if amount > (MAXIMUM_BALANCE - balance)
    @balance += amount
  end


  def touch_in(station_name)
    fail "Insufficient funds to travel" if @balance < MINIMUM_FARE
    journey.in_journey == true ? deduct(fare) : start_journey(station_name)
  end

  def touch_out(station_name)
    finish_journey(station_name)
    deduct(fare)
    journey.reset_journey
    journey_log.record_journey
  end

private

  def start_journey(station_name)
    journey.start(station_name)
    journey_log.start(station_name)
  end

  def finish_journey(station_name)
    journey.end(station_name)
    journey_log.end(station_name)
  end

  def deduct(amount)
    @balance -= amount
  end

  def fare
    journey.incomplete_journey? ? PENALTY_FARE : MINIMUM_FARE
  end
end
