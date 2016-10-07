require_relative 'start_end'

class Journey

  include StartEnd

  attr_reader :in_journey, :entry_station, :exit_station

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def reset_journey
     @entry_station = nil
     @exit_station = nil
  end

  def in_journey
    @entry_station != nil ? true : false
  end

  def incomplete_journey?
    @entry_station == nil || @exit_station == nil
  end
end
