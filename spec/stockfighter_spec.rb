require 'spec_helper'

describe Stockfighter do
  describe '#heartbeat' do
    it 'should return a hash with the keys ok and error' do
      allow(subject.client).to receive(:heartbeat).and_return({'ok' => false, 'error' => 'No actual API was called' })
      expect(subject.heartbeat).to eq({'ok' => false, 'error' => 'No actual API was called' })
    end
  end
end
