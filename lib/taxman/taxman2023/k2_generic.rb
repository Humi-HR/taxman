# frozen_string_literal: true

module Taxman2023
  # Calculates the generic k2 factor
  class K2Generic < Factor
    def self.params
      %i[pi pi_periodic b_pensionable b1_pensionable ie ie_periodic b_insurable b1_insurable p d d1]
    end
    attr_reader(*params)

    def rate
      raise StandardError "You must implement rate in subclass"
    end

    def amount
      ([cpp_credit, max_cpp_credit].min * rate) + ([ei_credit, max_ei_credit].min * rate)
    end

    def cpp_credit
      # If the contribution has already been reached, return max
      return max_cpp_credit if @d >= max_cpp_credit

      p * cpp_portion * lower_cpp_rate / higher_cpp_rate
    end

    def max_cpp_credit
      3_123_45.to_d
    end

    def cpp_portion
      [
        ((pi_periodic + ((b_pensionable + b1_pensionable) / p)) - (Cpp::BASIC_EXEMPTION / p)) * Cpp::RATE,
        0
      ].max
    end

    def ei_credit
      # If the contribution has already been reached, return max
      return max_ei_credit if @d1 >= max_ei_credit

      p * ei_portion
    end

    def max_ei_credit
      Ei::EI_MAX
    end

    def ei_portion
      (ie_periodic + ((b_insurable + b1_insurable) / p)) * Ei::EMPLOYEE_RATE
    end

    def lower_cpp_rate
      0.0495
    end

    def higher_cpp_rate
      0.0595
    end
  end
end
