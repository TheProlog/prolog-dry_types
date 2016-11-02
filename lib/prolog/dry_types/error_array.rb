# frozen_string_literal: true

require 'dry-types'
require 'prolog/dry_types/include_module'

# `Types` as a top-level namespace module seems to be a `dry-types` convention.
module Types
  ErrorArray = Types::Strict::Array.member(Types::Strict::Hash)
end
