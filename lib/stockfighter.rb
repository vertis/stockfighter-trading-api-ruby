require "stockfighter/version"
require "stockfighter/client"

module Stockfighter
  def self.heartbeat
    {'ok' => true, 'error' => ''}
  end
end
