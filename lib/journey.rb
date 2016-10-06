class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1
  attr_accessor :exit_station, :entry_station, :fare

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = 0
  end

  def in_journey?
    !!entry_station
  end

  def calculate_fare
    if @entry_station == nil || @exit_station == nil
      @fare = PENALTY_FARE
    elsif @entry_station == @exit_station
      @fare = MINIMUM_FARE
    else
      @fare = (@entry_station.zone - @exit_station.zone).abs
    end
  end
end
