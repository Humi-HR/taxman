# frozen_string_literal: true

require_relative "taxman/version"
require_relative "taxman/taxman2023/f5_a"
require_relative "taxman/taxman2023/f5_b"
require_relative "taxman/taxman2023/a"
require_relative "taxman/taxman2023/bpaf"
require_relative "taxman/taxman2023/t3"
require_relative "taxman/taxman2023/k2"
require_relative "taxman/taxman2023/c"
require_relative "taxman/taxman2023/ei"
require_relative "taxman/taxman2023/k2_generic"

require_relative "taxman/taxman2023/on/k2p"
require_relative "taxman/taxman2023/on/t4"

module Taxman
  class Error < StandardError; end
end
