# frozen_string_literal: true

module Taxman2024
  # Calculates the annualized income in the presence of a bonus
  class ABonus
    attr_accessor :a,
                  :current_bonus_term,
                  :ytd_bonus_term

    def initialize(a:, current_bonus_term:, ytd_bonus_term:)
      @a = a
      @current_bonus_term = current_bonus_term
      @ytd_bonus_term = ytd_bonus_term
    end

    def amount
      a_amount + current_bonus_term_amount + ytd_bonus_term_amount
    end

    def a_amount
      [a.amount, 0].max
    end

    def current_bonus_term_amount
      [current_bonus_term.amount, 0].max
    end

    def ytd_bonus_term_amount
      [ytd_bonus_term.amount, 0].max
    end
  end
end
