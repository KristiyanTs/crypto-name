class User < ApplicationRecord
  has_many :transactions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
end
