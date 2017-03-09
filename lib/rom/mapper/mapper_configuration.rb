require 'dry/core/class_builder'
require 'rom/mapper/mapper_dsl'

module ROM
  module Mapper
    # Setup DSL-specific mapper extensions
    #
    # @private
    module MapperConfiguration
      # Mapper definition DSL
      #
      # @example
      #
      #   setup.mappers do
      #     define(:users) do
      #       model name: 'User'
      #     end
      #
      #     define(:names, parent: :users) do
      #       exclude :id
      #     end
      #   end
      #
      # @api public
      def mappers(&block)
        register_mapper(*MapperDSL.new(self, mapper_classes, block).mapper_classes)
      end
    end
  end
end
