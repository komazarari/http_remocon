
module HttpRemocon
  module Filter
    class Commands
      attr_reader :commands, :to_match
      @@allowed_commands = [//]
      @@max_length = -1 # no limit

      def initialize(_commands, proc_to_match = ->(x) { x })
        @commands = Array(_commands)
        @to_match = proc_to_match
        @errors = ''
      end

      def pass?
        max_length_pass? && allowed_commands_pass?
      end

      def max_length_pass?
        case
        when @@max_length < 0; then true
        when commands.length <= @@max_length; then true
        else
          @errors +=
            "couldn't pass a condition: actual-length(#{commands.length}) <= max-length(#{@@max_length})\n"
          false
        end
      end

      def allowed_commands_pass?
        matchable = to_match.call(commands)
        @@allowed_commands.any? do |cond|
          cond.match matchable
        end
      end

      def error_message
        @errors
      end

      class << self
        def max_length
          @@max_length
        end

        def max_length=(new)
          @@max_length = new.to_i
        end

        def allowed_commands
          @@allowed_commands
        end

        def allowed_commands=(new)
          @@allowed_commands = Array(new)
        end

        def clear
          @@allowed_commands = [//]
          @@max_length = -1 # no limit
        end
      end
    end
  end
end
