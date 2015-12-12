require 'spec_helper'

describe Stockfighter do
  describe '#heartbeat' do
    it 'should return a hash with the keys ok and error' do
      expect(subject.heartbeat).to eq({'ok' => true, 'error' => '' })
    end
  end
end
