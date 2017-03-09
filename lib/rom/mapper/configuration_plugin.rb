require 'rom/mapper/mapper_dsl'

module ROM
  class Mapper
    # Model DSL allows setting a model class
    #
    # @private
    module ConfigurationPlugin
      # Mapper definition DSL used by Setup DSL
      #
      # @private

      def self.apply(configuration, options = {})
        configuration.class_eval do
          include MapperConfiguration
        end
      end
    end
  end
end
