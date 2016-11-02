# frozen_string_literal: true

require 'dry-types'
require 'prolog/dry_types/include_module'

# `Types` as a top-level namespace module seems to be a `dry-types` convention.
module Types
  # The original version of this type treated initialisation with an integer
  # value of zero as invalid, setting the initialised range to (-1..-1). On
  # reflection, this makes little sense as a general-purpose behaviour, as it is
  # highly likely to surprise casual users.
  IntegerRange = Range.constructor do |value|
    if value.respond_to?(:minmax) # Enumerable; eg, Range or Array
      value.min..value.max
    else # it *better* be an Integer
      0..value.to_i
    end
  end
end
