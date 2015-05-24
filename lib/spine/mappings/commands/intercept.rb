module Spine
  module Mappings
    module Commands
      class Intercept
        attr_reader :command, :action, :options

        def initialize(command, action, options = {})
          @command = command
          @options = options
          @action = action
        end

        def execute(source)
          value = command.execute(source) || options[:default]
          if value || !options.fetch(:nullable, false)
            action.call(value)
          else
            value
          end
        end
      end
    end
  end
end
