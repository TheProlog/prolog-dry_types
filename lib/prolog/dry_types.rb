# frozen_string_literal: true

require 'dry-types'

require 'prolog/dry_types/version'
require 'prolog/dry_types/range'

# `Types` as a top-level namespace module seems to be a `dry-types` convention.
module Types
  include Dry::Types.module
end

require_relative './dry_types/error_array'
require_relative './dry_types/integer_range'
require_relative './dry_types/time_or_now'
