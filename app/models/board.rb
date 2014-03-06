class Board < ActiveRecord::Base
  before_validation :generate_key_unless_present
  validates :key, :name, presence: true



  def to_param
    key
  end

private  
  def generate_key_unless_present
    self.key = SecureRandom.urlsafe_base64(20) unless key.present?
  end

end
