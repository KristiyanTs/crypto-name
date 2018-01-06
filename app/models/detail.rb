class Detail < ApplicationRecord
  belongs_to :user

  def to_details
    {
      "email"          => user.email,
      "nameFirst"      => details.first_name,
      "nameLast"       => details.last_name,
      "organization"   => details.organization,
      "phone"          => details.phone,
      "addressMailing" =>
      {
        "address1"    => details.address1,
        "city"        => details.city,
        "state"       => details.state,
        "postal_code" => details.code,
        "country"     => 'BG'
      }  
    }
  end
end
