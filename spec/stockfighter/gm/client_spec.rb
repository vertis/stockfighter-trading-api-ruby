require 'spec_helper'

describe Stockfighter::GM::Client do
  describe '#start_level' do
    subject { Stockfighter::GM::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => ENV['STARFIGHTER_AUTH_KEY'] } })}
    it 'should start the level' do
      VCR.use_cassette("start_level") do
        res = subject.start_level('first_steps')
        expect(res['ok']).to eq(true)
        #expect(res.keys).to eq(["ok", "instanceId", "account", "instructions", "tickers", "venues", "secondsPerTradingDay", "balances"])
      end
    end
  end

  describe '#restart_level' do
    subject { Stockfighter::GM::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => ENV['STARFIGHTER_AUTH_KEY'] } })}
    it 'should restart the level' do
      VCR.use_cassette("start_level") do
        @instance_id = subject.start_level('first_steps')["instanceId"]
      end
      VCR.use_cassette("restart_level") do
        res = subject.restart_level(@instance_id)
        expect(res['ok']).to eq(true)
        #expect(res.keys).to eq(["ok", "instanceId", "account", "instructions", "tickers", "venues", "secondsPerTradingDay", "balances"])
      end
    end
  end

  describe '#resume_level' do
    subject { Stockfighter::GM::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => ENV['STARFIGHTER_AUTH_KEY'] } })}
    it 'should resume the level' do
      VCR.use_cassette("start_level") do
        @instance_id = subject.start_level('first_steps')["instanceId"]
      end
      VCR.use_cassette("resume_level") do
        res = subject.resume_level(@instance_id)
        expect(res['ok']).to eq(true)
        #expect(res.keys).to eq(["ok", "instanceId", "account", "instructions", "tickers", "venues", "secondsPerTradingDay"])
      end
    end
  end

  describe '#level_status' do
    subject { Stockfighter::GM::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => ENV['STARFIGHTER_AUTH_KEY'] } })}
    it 'should get the level status' do
      VCR.use_cassette("start_level") do
        @instance_id = subject.start_level('first_steps')["instanceId"]
      end
      VCR.use_cassette("level_status") do
        res = subject.level_status(@instance_id)
        expect(res['ok']).to eq(true)
        #expect(res.keys).to eq(["ok", "done", "id", "state", "details"])
      end
    end
  end

  describe '#stop_level' do
    subject { Stockfighter::GM::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => ENV['STARFIGHTER_AUTH_KEY'] } })}
    it 'should stop the level' do
      VCR.use_cassette("start_level") do
        @instance_id = subject.start_level('first_steps')["instanceId"]
      end
      VCR.use_cassette("stop_level") do
        res = subject.stop_level(@instance_id)
        expect(res['ok']).to eq(true)
        expect(res).to eq({"ok" => true, "error" => ""})
      end
    end
  end
end
