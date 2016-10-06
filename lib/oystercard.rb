require_relative 'journey'
require_relative 'station'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station
  attr_accessor :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


  def initialize(balance = 0)
    @balance = balance
    @journey_log = JourneyLog.new(Journey)
  end

  def top_up(amount)
    fail "Card limit of £#{MAXIMUM_BALANCE} has been reached." if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient funds" if @balance < MINIMUM_BALANCE
    @journey_log.start(entry_station)
    @journey_log.active_journey.in_journey?
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.journeys.last.fare)
    @journey_log.active_journey.in_journey?
  end

  def in_current_journey?
    # @journey_log.active_journey.in_journey?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
