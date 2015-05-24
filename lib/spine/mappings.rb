module Spine
  module Mappings
    autoload :Repository, 'spine/mappings/repository'
    autoload :Mapper, 'spine/mappings/mapper'
    autoload :Strategies, 'spine/mappings/strategies'
    autoload :Mapping, 'spine/mappings/mapping'

    module Syntax
      autoload :Any, 'spine/mappings/syntax/any'
      autoload :String, 'spine/mappings/syntax/string'
      autoload :Integer, 'spine/mappings/syntax/integer'
      autoload :Decimal, 'spine/mappings/syntax/decimal'
      autoload :Boolean, 'spine/mappings/syntax/boolean'
      autoload :Date, 'spine/mappings/syntax/date'
      autoload :DateTime, 'spine/mappings/syntax/datetime'
      autoload :Timestamp, 'spine/mappings/syntax/timestamp'
      autoload :Nested, 'spine/mappings/syntax/nested'
      autoload :Collection, 'spine/mappings/syntax/collection'
      autoload :RegisteredMapper, 'spine/mappings/syntax/registered_mapper'
    end

    module Commands
      autoload :ActionFetch, 'spine/mappings/commands/action_fetch'
      autoload :Fetch, 'spine/mappings/commands/fetch'
      autoload :Intercept, 'spine/mappings/commands/intercept'
    end

    extend Repository
  end
end
