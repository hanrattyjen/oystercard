require 'oystercard'

class JourneyLog

  attr_accessor :journeys

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
  end

  def start
end
