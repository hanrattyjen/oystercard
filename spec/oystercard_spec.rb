require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) { double(:entry_station, :zone=>1) }
  let(:exit_station) { double(:exit_station, :zone=>2) }
  let(:journeylog) { double( ) }

  MINIMUM_FARE = 1

  describe 'initialization' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq 0
    end
    it 'does not have a set starting station' do
      expect(subject.entry_station).to eq nil
    end
  end

  context 'top-up card' do
    before do
      subject.top_up(described_class::MAXIMUM_BALANCE)
    end
    it 'allows a user to top-up their oystercard' do
      expect(subject.balance).to eq described_class::MAXIMUM_BALANCE
    end
    it 'will raise an error if maximum card value is reached' do
      message = "Card limit of £#{described_class::MAXIMUM_BALANCE} has been reached."
      expect{ subject.top_up(described_class::MINIMUM_BALANCE) }.to raise_error message
    end
  end

  it 'will raise error if balance is less than minimum fare' do
    expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient funds"
  end

  context 'using a card' do
    before do
      subject.top_up(described_class::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
    end
    describe '#touch_in' do
      it 'will set #in_current_journey? to true' do
        expect(subject).to be_in_current_journey
      end
    end
    describe '#touch_out' do
      it 'will set #in_current_journey? to false' do
        subject.touch_out(exit_station)
        expect(subject).to be_in_current_journey
      end
      it 'a single journey will reduce balance by minimum fare' do
        expect {subject.touch_out(exit_station)}.to change {subject.balance}.by(-MINIMUM_FARE)
      end
    end
  end

  context 'incorrect card usage' do
    before do
      subject.top_up(described_class::MINIMUM_BALANCE)
    end
    it 'will deduct a penalty if user fails to touch out' do
      subject.touch_in(entry_station)
      expect {subject.touch_in(entry_station)}.to change {subject.balance}.by(-journey.fare)
    end
    it 'will charge a penalty if user fails to touch in' do
      subject.touch_out(exit_station)
      expect {subject.touch_out(exit_station)}.to change {subject.balance}.by(-journey.fare)
    end
  end
end
