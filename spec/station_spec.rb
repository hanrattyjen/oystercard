require 'station'

describe Station do

  subject(:station) {described_class.new(:waterloo, 1)}
  describe '#initalization' do
    it 'should have a name' do
      expect(station.name).to be :waterloo
    end

    it 'should have a zone' do
      expect(station.zone).to be 1
    end
  end

end
