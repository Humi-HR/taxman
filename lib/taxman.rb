# frozen_string_literal: true

require_relative "taxman/version"
require_relative "taxman/taxman2023/f5_a"
require_relative "taxman/taxman2023/f5_b"
require_relative "taxman/taxman2023/a"
require_relative "taxman/taxman2023/bpaf"

module Taxman
  class Error < StandardError; end
end
