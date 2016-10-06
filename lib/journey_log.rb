require_relative 'journey'

class JourneyLog

  attr_reader :journeys, :entry_station, :exit_station

  def initialize(entry_station = nil, exit_station = nil)
    @journeys = []
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def end(exit_station)
    @exit_station = exit_station
  end


  def record_journey
    journeys << {in: @entry_station, out: @exit_station}
  end


end
