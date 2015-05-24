module Spine
  module Mappings
    module Strategies
      module Strict
        extend self

        def run(commands, source, destination = {})
          commands.reduce(destination) do |result, (key, command)|
            result[key] = command.execute(source)
            result
          end
        end
      end
    end
  end
end
