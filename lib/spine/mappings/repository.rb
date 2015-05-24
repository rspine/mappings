module Spine
  module Mappings
    # Maps objects to hash.
    #
    # == Types
    # * any - Value as is.
    # * integer - Integer, default value is 0.
    # * string - String, default value is ''.
    # * decimal - Floating point number, default value is 0.0.
    # * date - Date in ISO 8601 format (YYYY-MM-DD).
    # * datetime - Date and time in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ).
    # * timestamp - Date and time with milliseconds in ISO 8601 format
    #   (YYYY-MM-DDTHH:MM:SS.000Z).
    # * boolean - Boolean.
    #
    # Also you can use other serializers by name. They must be registered
    # before usage.
    #
    # == Options
    # * from - Method name for source object. Also you can use closure to fetch
    #   value
    # * nullable - Allows value to be nil.
    # * default - Default value.
    #
    # == Examples
    #
    #   Serialization.define :tag do
    #     integer :id, from: identity
    #     string :name
    #   end
    #
    #   Serialization.define :product do
    #     integer :id, from: identity
    #     string :name
    #     decimal :price
    #     boolean :is_available, { |source| source.available? }
    #     date :available_from
    #     date :avaialable_until
    #     tag :tags, nullable: true
    #     timestamp :created_at
    #     timestamp :updated_at
    #   end
    #
    #   serialized_product = Serialization.serialize(:product, product)
    #   serialized_products = Serialization.serialize_all(:product, products)
    module Repository
      def define(name, &block)
        mappings[name] = parse(block)
      end

      def find(*names)
        found_mappings = names.map { |name| mappings.fetch(name) }

        if found_mappings.empty?
          nil
        else
          Mapper.new(found_mappings)
        end
      end

      def mappings
        @mappings ||= {}
      end

      def parse(dsl)
        mapping = Mapping.new(self)
        mapping.instance_eval(&dsl)
        mapping
      end
    end
  end
end
