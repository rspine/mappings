module Spine
  module Mappings
    module Syntax
      module Any
        def any(destination, options = {}, &block)
          register(destination, build(destination, options, &block))
        end
      end
    end
  end
end
