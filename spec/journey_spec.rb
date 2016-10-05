require 'journey'
require 'oystercard'

describe Journey do

  let(:card) { Oystercard.new }
  # allow(card).to receive(:entry_station).and_return(entry_station)
  # allow(card?).to receive(:exit_station).and_return(exit_station)
  # allow(card).to receive(:)

  describe 'initialization' do
    it '#in_journey? be initially set to false' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe 'creating one journey' do
    it 'will create one journey' do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journeys).to include subject.journey
    end
  end

  describe '#add_journey' do
    it 'will add the journey to the journeys list' do
      expect(subject.add_journey(entry_station, exit_station)).to eq @journeys
    end
    it 'will reset the entry station on exit' do
      expect(subject.entry_station).to eq nil
    end
    it 'will reset the exit station on exit' do
      expect(subject.exit_station).to eq nil
    end
  end
end
