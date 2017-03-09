# frozen_string_literal: true

require 'test_helper'
require 'awesome_print'

require 'prolog/dry_types'

describe 'Testing' do
  describe 'defaults' do
    let(:demo_class) do
      Class.new(Dry::Struct::Value) do
        attribute :id1, Types::UUID
        attribute :id2, Types::UUID
      end
    end
    let(:obj) { demo_class.new }

    it 'work when no non-default attributes are specified' do
      actual = [:id1, :id2].map { |attr| obj.respond_to?(attr) }.uniq
      expect(actual).must_equal [true]
    end

    it 'fail when explicit values specified for some but not all attributes' do
      attribs = { id2: ::UUID.generate }
      expect { demo_class.new attribs }.must_raise Dry::Struct::Error
    end
  end # describe 'defaults'
end
