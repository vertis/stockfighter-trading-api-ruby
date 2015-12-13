require 'spec_helper'

describe Stockfighter::GM::Client do
  describe '#start_level' do
    subject { Stockfighter::GM::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => ENV['STARFIGHTER_AUTH_KEY'] } })}
    it 'should start the level' do
      VCR.use_cassette("start_level") do
        res = subject.start_level('first_steps')
        expect(res['ok']).to eq(true)
        expect(res.keys).to eq(["ok", "instanceId", "account", "instructions", "tickers", "venues", "secondsPerTradingDay"])
      end
    end
  end
end
