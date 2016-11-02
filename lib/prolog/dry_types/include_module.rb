# frozen_string_literal: true

require 'prolog/dry_types/range'

# `Types` as a top-level namespace module seems to be a `dry-types` convention.
module Types
  include Dry::Types.module
end
