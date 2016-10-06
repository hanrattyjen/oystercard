require 'oystercard'

class JourneyLog

	attr_reader :journeys
  attr_accessor :current_journey

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
  end

  def start(station)
  	@current_journey = @journey_class.new(station)
  end

  def finish(station)
  	@current_journey.exit_station = station
  	@current_journey.fare = @current_journey.calculate_fare 
  	update_log
  end

  def journeys
  	@journeys
  end

  def update_log
  	@journeys << @current_journey
  end

  private

  def current_journey
  	@current_journey || @journey_class.new
  end
end
