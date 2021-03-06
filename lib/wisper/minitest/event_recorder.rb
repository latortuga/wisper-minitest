module Wisper
  module Minitest
    class EventRecorder
      attr_reader :broadcast_events
      attr_reader :event_name
      attr_reader :args

      def initialize
        @broadcast_events = []
      end

      def respond_to?(method_name)
        true
      end

      def method_missing(method_name, *args, &block)
        @broadcast_events << [method_name.to_s, *args]
      end

      def broadcast?(event_name, *args)
        @event_name = event_name
        @args = args
        
        if args.size > 0
          @broadcast_events.include?([event_name.to_s, *args])
        else
          @broadcast_events.map(&:first).include?(event_name.to_s)
        end
      end
    end
  end
end
