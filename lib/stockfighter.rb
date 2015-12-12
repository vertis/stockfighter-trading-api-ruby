require "stockfighter/version"

module Stockfighter
  def self.heartbeat
    {'ok' => true, 'error' => ''}
  end
end
