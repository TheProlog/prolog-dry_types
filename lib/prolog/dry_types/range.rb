# frozen_string_literal: true

require 'dry-types'

# These need to be before `Dry::Types.module` is included. Also,
# obviously, after requiring `dry-types`.
Dry::Types.register 'range', Dry::Types::Definition[Range].new(Range)
Dry::Types.register 'strict.range',
                    Dry::Types['range'].constrained(type: Range)
