class Administrator < ApplicationRecord
  # Others available devise modules are:
  # :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :lockable

  validates :nickname, presence: true
end
