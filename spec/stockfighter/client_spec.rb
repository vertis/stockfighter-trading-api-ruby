require 'spec_helper'

describe Stockfighter::Client do
  describe '#heartbeat' do
    it 'get the status of the API' do
      response = double()
      allow(response).to receive(:parsed_response).and_return({'ok' => false, 'error' => 'Fake Error'})
      expect(Stockfighter::Client).to receive(:get).with('/heartbeat').and_return(response)
      expect(subject.heartbeat).to eq({'ok' => false, 'error' => 'Fake Error'})
    end
  end

  describe '#venue_heartbeat' do
    it 'should get the status of the venue' do
      response = double()
      allow(response).to receive(:parsed_response).and_return({'ok' => true, 'venue' => 'TESTEX'})
      expect(Stockfighter::Client).to receive(:get).with('/venue/TESTEX/heartbeat').and_return(response)
      expect(subject.venue_heartbeat('TESTEX')).to eq({'ok' => true, 'venue' => 'TESTEX'})
    end
  end
end
