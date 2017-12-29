class Detail < ApplicationRecord
  belongs_to :user

  def activate!
    user.details.update_all(active: false)
    self.update(active: true)
  end
end
