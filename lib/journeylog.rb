require 'oystercard'

class JourneyLog

  attr_accessor :journeys, :current_journey

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
  end

  def start(station)
  	@current_journey = @journey_class.new(station)
  	@journeys << @current_journey
  end

  def finish(station)
  	@current_journey.exit_station = station
  end

  private

  def current_journey
  	@current_journey || @journey_class.new
  end
end
