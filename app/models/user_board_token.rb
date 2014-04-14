class UserBoardToken < ActiveRecord::Base
  belongs_to :user
  belongs_to :board

  validates :user_id, :board_id, :key, presence: true
  validates :key, uniqueness: true

  before_validation :set_key_unless_present

  def to_param
    key
  end

  def self.for(user:, board:)
    where(user: user, board: board).first_or_create
  end

private
  def set_key_unless_present
    self.key = SecureRandom.urlsafe_base64(20) unless key.present?
  end
end
