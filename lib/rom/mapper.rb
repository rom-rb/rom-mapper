require 'rom/mapper/dsl'

require 'rom/support/inheritance_hook'

module ROM
  # Mapper is a simple object that uses transformers to load relations
  #
  # @private
  class Mapper
    extend ROM::Support::InheritanceHook
    include DSL
    include Equalizer.new(:transformers, :header)

    defines :relation, :register_as, :symbolize_keys,
      :prefix, :prefix_separator, :inherit_header, :reject_keys

    inherit_header true
    reject_keys false
    prefix_separator '_'.freeze

    class << self; alias_method :build, :new; end

    # @return [Object] transformers object built by a processor
    #
    # @api private
    attr_reader :transformers

    # @return [Header] header that was used to build the transformers
    #
    # @api private
    attr_reader :header

    # @return [Hash] registered processors
    #
    # @api private
    def self.processors
      @_processors ||= {}
    end

    # Register a processor class
    #
    # @return [Hash]
    #
    # @api private
    def self.register_processor(processor)
      name = processor.name.split('::').last.downcase.to_sym
      processors.update(name => processor)
    end

    # Prepares an array of headers for a potentially multistep mapper
    #
    # @return [Array<Header>]
    #
    # @api private
    def self.headers
      return [header] if steps.empty?
      return steps.map(&:header) if attributes.empty?
      raise(MapperMisconfiguredError, "cannot mix outer attributes and steps")
    end

    # @api private
    def self.registry(descendants)
      descendants.each_with_object({}) do |klass, h|
        name = klass.register_as || klass.relation
        (h[klass.base_relation] ||= {})[name] = klass.build
      end
    end

    # @api private
    def initialize(processor: :transproc)
      processor = Mapper.processors.fetch(processor)
      @transformers = self.class.headers.map { |header| processor.build(self, header) }
      @header = self.class.header
    end

    # @return [Class] optional model that is instantiated by a mapper
    #
    # @api private
    def model
      header.model
    end

    # Process a relation using the transformers
    #
    # @api private
    def call(relation)
      transformers.reduce(relation.to_a) { |a, e| e.call(a) }
    end
  end
end
