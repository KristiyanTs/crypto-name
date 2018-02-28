# frozen_string_literal: true

class Detail < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :domain, optional: true

  validates :first_name, :last_name, :phone, :address1, :email, :city, :country, :state, :postal_code, presence: true

  def to_details
    {
      'email'          => user.email,
      'nameFirst'      => first_name,
      'nameLast'       => last_name,
      'organization'   => organization,
      'phone'          => phone,
      'addressMailing' =>
      {
        'address1'    => address1,
        'city'        => city,
        'state'       => state,
        'postalCode'  => postal_code,
        'country'     => 'BG'
      }
    }
  end
end
