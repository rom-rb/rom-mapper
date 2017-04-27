require 'spec_helper'

RSpec.describe ROM::Mapper::MapperDSL do
  subject(:mapper_dsl) do
    ROM::Mapper::MapperDSL.new(ROM::Configuration.new(:memory), [], block)
  end

  let(:block) do
    lambda do
      define(:users) do
        model name: 'User'
      end
    end
  end

  let(:mapper_classes) { subject.mapper_classes }

  context "Evaluate block" do
    it "store new created Mapper class" do
      expect(mapper_classes).to_not be_empty
    end

    it "create a valid Mapper class" do
      expect(mapper_classes.first.name).to eq "ROM::Mapper[users]"
    end
  end
end
