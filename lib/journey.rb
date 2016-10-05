class Journey
  attr_reader :entry_station
  attr_accessor :exit_station, :journey

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
    @journey = {}
  end

  def add_journey
    @journey.merge!({entry_station: @entry_station, exit_station: @exit_station})
    reset_stations
  end

  def in_journey?
    !!entry_station
  end

  private

  def reset_stations
    @entry_station = nil
    @exit_station = nil
  end
end
