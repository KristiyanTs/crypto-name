class Detail < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :phone, :address1, :email, :city, :state, :postal_code, presence: true

  def to_details
    {
      "email"          => user.email,
      "nameFirst"      => first_name,
      "nameLast"       => last_name,
      "organization"   => organization,
      "phone"          => phone,
      "addressMailing" =>
      {
        "address1"    => address1,
        "city"        => city,
        "state"       => state,
        "postalCode"  => postal_code,
        "country"     => 'BG'
      }  
    }
  end
end
