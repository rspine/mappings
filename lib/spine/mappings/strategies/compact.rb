module Spine
  module Mappings
    module Strategies
      module Compact
        extend self

        def run(commands, source, destination = {})
          commands.reduce(destination) do |result, (key, command)|
            value = command.execute(source)
            result[key] = value if value
            result
          end
        end
      end
    end
  end
end
