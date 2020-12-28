class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable
  paginates_per 20

  belongs_to :client
  has_and_belongs_to_many :segments
  has_many :survey_user_relations
  has_many :surveys, through: :survey_user_relations
  has_many :answers
  validates :first_name, :last_name, :email, :account_type, :age, :position_age, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'is not an email' }
  validates :age, numericality: { only_integer: true, greater_than: 0 }

  scope :filter_by_client_id, ->(id) { where(client_id: id) }
  scope :filter_avaible_by_survey_id, ->(survey_id) { joins(:survey_user_relations).where(survey_user_relations: { survey_id: survey_id, is_conducted: false }) }
  scope :filter_conducted_by_survey_id, ->(survey_id) { joins(:survey_user_relations).where(survey_user_relations: { survey_id: survey_id, is_conducted: true }) }
end
