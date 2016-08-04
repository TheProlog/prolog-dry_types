# frozen_string_literal: true

require 'test_helper'

require 'prolog/dry_types/error_array'

describe 'Types::ErrorArray' do
  let(:attribute_class) do
    Class.new(Dry::Types::Value) do
      attribute :errors, Types::ErrorArray
    end
  end

  describe 'can be initialised with' do
    after do
      obj = attribute_class.new errors: @errors
      expect(obj.errors).must_equal @errors
    end

    it 'an empty Array' do
      @errors = []
    end

    it 'an Array of error Hashes' do
      @errors = [{ error1: :error_value }, { error2: 'another value' }]
    end
  end # describe 'can be initialised with'
end
