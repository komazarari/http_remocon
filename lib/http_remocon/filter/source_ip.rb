
module HttpRemocon
  module Filter
    class SourceIP
#      attr_reader :commands
#      @@allowed_commands = [/.*/]
#      @@max_length = -1 # no limit

      def initialize(src_ip)
        @src_ip = src_ip
#        @commands = Array(_commands)
      end

      def pass?
        true
      end

      class << self
      end
    end
  end
end
