module Spine
  module Mappings
    module Syntax
      module Collection
        def collection(type, destination, options = {}, &block)
          command = build(destination, options, &block)
          register(
            destination,
            intercept(command, options) {
              |value| repository.find(type).map_all(value)
            }
          )
        end
      end
    end
  end
end
