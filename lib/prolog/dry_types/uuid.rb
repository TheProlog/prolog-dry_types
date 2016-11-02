# frozen_string_literal: true

require 'uuid'

require 'dry-types'
require 'prolog/dry_types/include_module'

# `Types` as a top-level namespace module seems to be a `dry-types` convention.
module Types
  UUID_FORMAT = /\A\h{8}(-\h{4}){3}\-\h{12}\z/
  UUID = Types::Strict::String.default { ::UUID.generate }
                              .constrained(format: UUID_FORMAT)
end
