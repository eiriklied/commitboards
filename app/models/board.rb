class Board < ActiveRecord::Base

  has_many :commits, -> { order(committed_at: :desc) }
  belongs_to :owner, class_name: 'User'

  before_validation :generate_key_unless_present
  validates :key, :name, presence: true

  validates :owner_id, presence: true

  def to_param
    key
  end

  def user_board_token_for(user)

  end

private
  def generate_key_unless_present
    self.key = SecureRandom.urlsafe_base64(20) unless key.present?
  end

end
