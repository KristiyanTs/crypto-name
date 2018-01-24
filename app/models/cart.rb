class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :items

  def calculate_subtotal
    self.update_columns(subtotal: items.sum('price_total'))
  end

  def calculate_total
    calculate_subtotal
    subtotal + fees + vat
  end

  private 

  def fees
    items.where(entity: "domain").count * 18
  end

  def vat
    (subtotal + fees)*country_vat
  end

  def country_vat
    case user.detail.country
    when 'AT' #Austria
      return 0.20
    when 'BE' #Belgium
      return 0.21
    when 'BG' #Bulgaria
      return 0.20
    when 'CY' #Cyprus
      return 0.19
    when 'CZ' #Czech Republic
      return 0.21
    when 'De' #Germany
      return 0.19
    when 'DK' #Denmark
      return 0.25
    when 'EE' #Estonia
      return 0.20
    when 'EL' #Greece
      return 0.24
    when 'ES' #Spain
      return 0.21
    when 'FI' #Finland
      return 0.24
    when 'FR' #France
      return 0.20
    when 'HR' #Croatia
      return 0.25
    when 'HU' #Hungary
      return 0.27
    when 'IE' #Ireland
      return 0.23
    when 'IT' #Italy
      return 0.22
    when 'LT' #Lithuania
      return 0.21
    when 'LU' #Luxembourg
      return 0.17
    when 'LV' #Latvia
      return 0.21
    when 'MT' #Malta
      return 0.18
    when 'NL' #Netherlands
      return 0.21
    when 'PL' #Poland
      return 0.23
    when 'PT' #Portugal
      return 0.23
    when 'RO' #Romania
      return 0.19
    when 'SE' #Sweden
      return 0.25
    when 'SI' #Slovenia
      return 0.22
    when 'SK' #Slovakia
      return 0.20
    when 'UK' #United Kingdom
      return 0.20
    else
      return 0
    end
  end
end
