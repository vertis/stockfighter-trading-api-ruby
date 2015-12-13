module Stockfighter
  module GM
    class Client
      include HTTParty

      base_uri "https://api.stockfighter.io/gm"

      def initialize(options={})
        self.class.headers options['headers'] if options['headers']
      end

      def start_level(name)
        self.class.post("/levels/#{name}").parsed_response
      end

      def restart_level(instance_id)
        self.class.post("/instances/#{instance_id}/restart").parsed_response
      end

      def stop_level(instance_id)
        self.class.post("/instances/#{instance_id}/stop").parsed_response
      end

      def resume_level(instance_id)
        self.class.post("/instances/#{instance_id}/resume").parsed_response
      end

      def level_status(instance_id)
        self.class.get("/instances/#{instance_id}").parsed_response
      end
    end
  end
end
