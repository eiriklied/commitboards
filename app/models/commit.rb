class Commit < ActiveRecord::Base
  belongs_to :board

  validates :name, :email, :project, # add :committed_at when the timestamp setter method works
            presence: true
  validates :board_id, presence: true

  has_attached_file :image


  def timestamp=(timestamp)
    Rails.logger.warn 'Need to convert this timestamp to a datetime'
    #self.committed_at = timestamp
  end
end
