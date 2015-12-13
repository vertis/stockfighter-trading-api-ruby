require 'spec_helper'

describe Stockfighter::GM::Client do
  describe '#start_level' do
    subject { Stockfighter::GM::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => 'fakeKey' } })}
    it 'should start the level' do
      VCR.use_cassette("start_level") do
        res = subject.start_level('first_steps')
        expect(res['ok']).to eq(true)
        expect(res.keys).to eq(%w(account instanceId instructions ok secondsPerTradingDay tickers venues))
      end
    end
  end
end
