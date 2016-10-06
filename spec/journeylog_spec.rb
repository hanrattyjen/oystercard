require 'journeylog'

describe JourneyLog do

  let(:journeylog) { described_class.new(:journey_class) }

  describe 'initialization' do
    it 'will not contain any journeys in its log' do
      expect(subject.journeys).to eq []
    end
  end

  it 'will store one journey in its history' do
    expect(subject.journeys). to eq journeys
  end

end
