# frozen_string_literal: true

require 'dry-types'

# `Types` as a top-level namespace module seems to be a `dry-types` convention.
module Types
  include Dry::Types.module # should have already been included

  TimeOrNow = Types::Strict::Time.default { ::Time.now }
end
