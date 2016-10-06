class JourneyLog

	attr_reader :journeys
  attr_accessor :active_journey

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
    @active_journey = nil
  end

  def start(station)
  	@active_journey = @journey_class.new(station)
  end

  def finish(station)
  	@active_journey.exit_station = station
  	@active_journey.fare = @active_journey.calculate_fare
  	update_log
  end

  def journeys
  	@journeys
  end

  def update_log
  	@journeys << @active_journey
  end

  private

  def current_journey
  	@active_journey || @journey_class.new
  end
end
