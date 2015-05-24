module Spine
  module Mappings
    module Commands
      class ActionFetch
        attr_reader :action

        def initialize(action)
          @action = action
        end

        def execute(source)
          action.call(source)
        end
      end
    end
  end
end
