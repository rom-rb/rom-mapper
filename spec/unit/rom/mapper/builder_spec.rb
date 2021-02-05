require 'spec_helper'

RSpec.describe ROM::Mapper::Builder do
  subject(:mapper)do
    ROM::Mapper::Builder.build_class(name, mapper_registry, options) do
      model name: 'User'
    end
  end
  let(:name) { "users" }

  context "#build_class" do
    context "parent" do
      context "Without options" do
        let(:mapper_registry) { [] }
        let(:options) { {} }

        it "will default to ROM::Mapper" do
          expect(mapper.ancestors).to include(ROM::Mapper)
        end
      end

      context "With parent options" do
        let(:name) { "cars" }
        let(:relation) do
          klass = Class.new(ROM::Mapper)
          klass.relation('vehicule')
          klass
        end
        let(:mapper_registry) { [relation] }
        let(:options) { {parent: 'vehicule'} }

        it "will set parent as ancestor" do
          expect(mapper.ancestors).to include(relation)
        end
      end
    end

    context "inherit_header" do
      context "Without options" do
        let(:mapper_registry) { [] }
        let(:options) { {} }

        it "will default to ROM::Mapper" do
          expect(mapper.inherit_header).to eq true
        end
      end

      context "With options" do
        let(:mapper_registry) { [] }
        let(:options) { { inherit_header: false } }

        it "will default to ROM::Mapper" do
          expect(mapper.inherit_header).to eq false
        end
      end
    end
  end

end
