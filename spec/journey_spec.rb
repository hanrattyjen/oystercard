require 'journey'
require 'oystercard'

describe Journey do

  subject(:journey) {described_class.new(:entry_station)}
  subject(:nil_test) {described_class.new(:entry_station)}
  let(:card) { Oystercard.new }
  let(:entry_station) { double(:station, :zone=>1) }
  let(:exit_station) { double(:station, :zone=>2) }

  describe 'initialization' do
    it 'will set #in_journey? to true' do
      expect(journey.in_journey?).to eq true
    end

    it "will set station to entry station" do
      expect(journey.entry_station).to be :entry_station
    end

   end

   describe 'adding one journey to history' do
    let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
    before do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
    end

  end

 end
