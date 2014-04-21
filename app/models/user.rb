class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :user_board_tokens
  has_many :boards, through: :user_board_tokens
  has_many :commits

  validates :email, :name, :github_url, :avatar_url, presence: true

  def board_commits(board)
    self.commits.where(board: board)
  end

  def email=(str)
    super(str.downcase) if str.present?
  end
end
