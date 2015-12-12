require 'spec_helper'

describe Stockfighter::Client do
  describe '#heartbeat' do
    it 'get the status of the API' do
      response = double()
      allow(response).to receive(:parsed_response).and_return({'ok' => false, 'error' => 'Fake Error'})
      allow(Stockfighter::Client).to receive(:get).and_return(response)
      expect(subject.heartbeat).to eq({'ok' => false, 'error' => 'Fake Error'})
    end
  end
end
