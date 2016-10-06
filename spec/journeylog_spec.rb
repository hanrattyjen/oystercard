require 'journeylog'

describe JourneyLog do

  subject(:journeylog) { described_class.new(Journey) }
  let(:station) { double(:station, :zone => 1) }

  describe 'initialization' do
    it 'will not contain any journeys in its log' do
      expect(subject.journeys).to eq []
    end
  end

  it 'will store one journey in its history' do
  	initial_count = subject.journeys.count
  	subject.start(station)
    expect(subject.journeys.count).to be > initial_count
  end

  describe '#finish' do

  	it 'adds an exit station to the current journey' do
  		subject.start(station)
  		subject.finish(station)
  		expect(subject.current_journey.exit_station).to eq station
  	end

  end


end
