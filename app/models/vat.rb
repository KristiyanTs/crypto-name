# frozen_string_literal: true

class Vat
  COUNTRY_VAT = { 'AT' => 0.20, 'BE' => 0.21, 'BG' => 0.20, 'CY' => 0.19, 'CZ' => 0.21,
                  'DE' => 0.19, 'DK' => 0.25, 'EE' => 0.20, 'EL' => 0.24, 'ES' => 0.21,
                  'FI' => 0.24, 'FR' => 0.20, 'HR' => 0.25, 'HU' => 0.27, 'IE' => 0.23,
                  'IT' => 0.22, 'LT' => 0.21, 'LU' => 0.17, 'LV' => 0.21, 'MT' => 0.18,
                  'NL' => 0.21, 'PL' => 0.23, 'PT' => 0.23, 'RO' => 0.19, 'SE' => 0.25,
                  'SI' => 0.22, 'SK' => 0.20, 'UK' => 0.20 }.freeze

  attr_reader :percent

  def initialize(country)
    @percent = COUNTRY_VAT[country] || 0
  end

  def call
    percent
  end
end
