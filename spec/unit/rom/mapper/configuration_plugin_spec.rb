require 'spec_helper'

RSpec.describe ROM::Mapper::ConfigurationPlugin do
  subject(:configuration) do
    ROM::Mapper::ConfigurationPlugin.apply(ROM::Configuration.new(:memory))
  end

  context "Interface" do
    it "have #mappers method" do
      expect(configuration.respond_to?(:mappers)).to eq true
    end
  end
end
