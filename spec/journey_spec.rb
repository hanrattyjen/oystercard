require 'journey'
require 'oystercard'

describe Journey do

  subject(:journey) {described_class.new(:entry_station)}
  subject(:nil_test) {described_class.new(:entry_station)}
  let(:card) { Oystercard.new }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe 'initialization' do
    it 'will set #in_journey? to true' do
      expect(journey.in_journey?).to eq true
    end

    it "will set station to entry station" do
      expect(journey.entry_station).to be :entry_station
    end

   end

   describe 'creating one journey' do
    let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
    before do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
    end

    it 'will create one journey' do
      expect(card.journeys).to include journey
    end
  end

  describe '#reset_stations' do
    before do
      subject.reset_stations
    end

    it 'will reset the entry station' do
      expect(subject.entry_station).to be nil
    end

    it 'will reset the exit station on exit' do
      expect(subject.exit_station).to be nil
    end
   end

  describe '#penalty_fare?' do
    before do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(entry_station)
    end

    it 'should deduct MINIMUM_FARE if user touches in/out correctly' do
       card.touch_out(exit_station)
       expect(subject.penalty_fare?).to be true
    end

    it 'should deuct penalty fare if user does not touch out' do
      card.touch_out(exit_station)
      card.touch_out(exit_station)
      expect(subject.penalty_fare?).to be false
    end
  end


end
