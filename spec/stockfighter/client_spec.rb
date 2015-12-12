require 'spec_helper'

describe Stockfighter::Client do
  describe '#heartbeat' do
    it 'get the status of the API' do
      VCR.use_cassette("heartbeat") do
        expect(subject.heartbeat).to eq({'ok' => true, 'error' => ''})
      end
    end
  end

  describe '#venue_heartbeat' do
    it 'should get the status of the venue' do
      VCR.use_cassette("venue_heartbeat") do
        expect(subject.venue_heartbeat('TESTEX')).to eq({'ok' => true, 'venue' => 'TESTEX'})
      end
    end
  end

  describe '#venue_stocks' do
    it 'should get the stocks available on the venue' do
      VCR.use_cassette("venue_stocks") do
        expect(subject.venue_stocks('TESTEX')).to eq({ 'ok' => true, 'symbols' => [{'name'=>'Foreign Owned Occluded Bridge Architecture Resources', 'symbol'=>'FOOBAR'}] })
      end
    end
  end

  describe '#venue_stock_orderbook' do
    it 'should get the orderbook for the given stock on the given venue' do
      VCR.use_cassette("venue_stock_orderbook") do
        res = subject.venue_stock_orderbook('TESTEX', 'FOOBAR')
        expect(res['ok']).to eq(true)
        expect(res.keys).to eq(["ok", "venue", "symbol", "ts", "bids", "asks"])
      end
    end
  end
end
