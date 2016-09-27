# frozen_string_literal: true

require 'test_helper'

require 'prolog/dry_types/setup'
require 'prolog/dry_types/integer_range'

describe 'Types::IntegerRange' do
  let(:attribute_class) do
    Class.new(Dry::Struct::Value) do
      attribute :range, Types::IntegerRange
    end
  end
  let(:init_range) { 5..25 }
  let(:top_end) { 8 }

  describe 'can be initialised with' do
    after do
      expect(@obj.range).must_equal @range
    end

    it 'a Range' do
      @range = init_range
      @obj = attribute_class.new range: init_range
    end

    it 'an integer' do
      @range = 0..42
      @obj = attribute_class.new range: 42
    end

    it 'an Array of integers representing a Range' do # See Issue #1.
      @range = init_range
      @obj = attribute_class.new range: init_range.to_a
    end
  end # describe 'can be initialised with'

  describe 'when initialised with' do
    it 'a Range, is equal to that Range' do
      obj = attribute_class.new range: init_range
      expect(obj.range).must_equal init_range
    end

    it 'an Integer, is a Range from 0 to that value, inclusive' do
      obj = attribute_class.new range: top_end
      expect(obj.range).must_equal 0..top_end
    end

    # See Issue #1.
    it 'an Array of integers, is a Range spanning the values in that Array' do
      obj = attribute_class.new range: init_range.to_a
      expect(obj.range).must_equal init_range
    end
  end # describe 'when initialised with'
end
