class Commit < ActiveRecord::Base
  belongs_to :board

  validates :name, :email, :project, # add :committed_at when the timestamp setter method works
            presence: true
  validates :board_id, presence: true

  has_attached_file :image


  def timestamp=(timestamp)
    self.committed_at = DateTime.strptime(timestamp.to_s,'%s')
  end
end
