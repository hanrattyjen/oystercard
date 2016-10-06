require 'spec_helper'

describe JourneyLog do

  let(:card) {Oystercard.new(Oystercard::MINIMUM_FARE)}
  let(:station1) {double(:station)}
  let(:station2) {double(:station)}

  it "stores a whole journey in an array of hashes" do
    card.touch_in(station1)
    card.touch_out(station2)
    expect(card.journey_log.journeys).to match_array([in: station1, out: station2])
  end



  # describe '#initialize' do
  #   it "stores a whole journey in an array of hashes" do
  #     card.touch_in(station1)
  #     card.touch_out(station2)
  #     expect(card.journey.journey_log.journey_history).to match_array([in: station1, out: station2])
  #   end
  # end
end
