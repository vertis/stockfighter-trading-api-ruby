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

  describe '#restart_level' do
    subject { Stockfighter::GM::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => ENV['STARFIGHTER_AUTH_KEY'] } })}
    it 'should restart the level' do
      pending "Stockfighter is having issues right now"
      VCR.use_cassette("start_level") do
        @instance_id = subject.start_level('first_steps')["instanceId"]
      end
      VCR.use_cassette("restart_level") do
        res = subject.restart_level(@instance_id)
        expect(res['ok']).to eq(true)
        expect(res.keys).to eq(["ok", "instanceId", "account", "instructions", "tickers", "venues", "secondsPerTradingDay"])
      end
    end
  end

  describe '#resume_level' do
    subject { Stockfighter::GM::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => ENV['STARFIGHTER_AUTH_KEY'] } })}
    it 'should resume the level' do
      pending "Stockfighter is having issues right now"
      VCR.use_cassette("start_level") do
        @instance_id = subject.start_level('first_steps')["instanceId"]
      end
      VCR.use_cassette("resume_level") do
        res = subject.resume_level(@instance_id)
        expect(res['ok']).to eq(true)
        expect(res.keys).to eq(["ok", "instanceId", "account", "instructions", "tickers", "venues", "secondsPerTradingDay"])
      end
    end
  end
end
