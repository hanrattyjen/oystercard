require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station
  attr_accessor :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(balance = 0)
    @balance = balance
    @journeys = Journey.new(:Journey)
    @user_touch_in = false
  end

  def top_up(amount)
    fail "Card limit of £#{MAXIMUM_BALANCE} has been reached." if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient funds" if @balance < MINIMUM_BALANCE
    did_user_double_touch_in
    create_journey(entry_station)
    @user_touch_in = true
    @journey.in_journey?
  end

  def touch_out(exit_station)
    user_did_not_touch_in
    @journey.exit_station = exit_station
    deduct(calculate_fare)
    add_journey_to_history
    @journey.in_journey?
  end

  private

  def calculate_fare
    if @journey.entry_station == nil || @journey.exit_station == nil
      1
    else
      (@journey.entry_station.zone - @journey.exit_station.zone).abs
    end
  end

  def add_journey_to_history
    add_to_array
    reset_touch_in
  end

  def did_user_double_touch_in
    if @user_touch_in == true
      deduct(PENALTY_FARE + MINIMUM_FARE)
    end
  end

  def create_journey(entry_station)
    @journey = Journey.new(entry_station)
  end

  def user_did_not_touch_in
    if @user_touch_in == false
       create_journey(exit_station)
       deduct(PENALTY_FARE)
    end
  end

  def reset_touch_in
    @user_touch_in = false
  end

  def add_to_array
    @journey.add_journey
    @journeys << @journey.journey
  end

  def deduct(amount)
    @balance -= amount
  end

end
