# frozen_string_literal: true

module Taxman2023
  # Value of personal tax credits shown on form TP-1015.3-V
  class QcE < Factor
    def self.params
      %i[qc_e1 qc_e2]
    end
    attr_reader(*params)

    def amount
      evaluate "round(qc_e1 + qc_e2)"
    end
  end
end
