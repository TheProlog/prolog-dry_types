# frozen_string_literal: true

require 'test_helper'

require 'prolog/dry_types/uuid'

describe 'Types::TimeOrNow' do
  let(:attribute_class) do
    Class.new(Dry::Types::Value) do
      attribute :uuid, Types::UUID
    end
  end
  let(:uuid) { UUID.generate } # presumed to be valid

  describe 'can be initialised with' do
    it 'nil, to produce a validly-formatted UUID string' do
      obj = attribute_class.new uuid: nil
      expect(UUID.validate(obj.uuid)).must_equal true
    end

    it 'a validly-formatted UUID string' do
      obj = attribute_class.new uuid: uuid
      expect(obj.uuid).must_equal uuid
    end
  end # describe 'can be initialised with'
end
