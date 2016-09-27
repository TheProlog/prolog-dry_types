# frozen_string_literal: true

require 'test_helper'

require 'prolog/dry_types/setup'
require 'prolog/dry_types/time_or_now'

describe 'Types::TimeOrNow' do
  let(:attribute_class) do
    Class.new(Dry::Struct::Value) do
      attribute :torn, Types::TimeOrNow
    end
  end
  let(:dummy_time) { Time.parse dummy_time_str }
  let(:dummy_time_str) { '30 Jul 2016 12:34:56 SGT' }

  describe 'supports initialisation with' do
    after do
      @obj ||= attribute_class.new torn: @stamp
      expect(@obj.torn).must_equal dummy_time
    end

    it 'nil to use the current time' do # with some wiggle room for testing
      Time.stub :now, dummy_time do
        @obj = attribute_class.new
      end
    end

    it 'a Time instance' do
      @stamp = dummy_time
    end
  end # describe 'supports initialisation with'

  describe 'does not support initialisation with' do
    let(:error_class) { Dry::Struct::Error }

    after do
      expect { attribute_class.new torn: @stamp }.must_raise error_class
    end

    it 'a Date instance' do
      @stamp = dummy_time.to_date
    end

    it 'a DateTime instance' do
      @stamp = DateTime.now
    end

    it 'a string with a parseable timestamp' do
      @stamp = dummy_time_str
    end
  end # describe 'does not support initialisation with'
end
