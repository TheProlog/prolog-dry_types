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
      expect(obj).must_respond_to :id1
      expect(obj).must_respond_to :id2
    end

    it 'fail when explicit values specified for some but not all attributes' do
      attribs = { id2: ::UUID.generate }
      expect { demo_class.new attribs }.must_raise Dry::Struct::Error
    end
  end # describe 'defaults'
end
