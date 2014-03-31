class Commit < ActiveRecord::Base
  belongs_to :board

  validates :name, :email, :project, :sha, # add :committed_at when the timestamp setter method works
            presence: true
  validates :board_id, presence: true

  has_attached_file :image,
                    styles: {medium: ['400x225', :jpg]},
                    default_style: :medium,
                    # couldnt get this to work from paperclip_settings so have to apply to all models with image attachments..
                    # remove all exif information since ipad actually
                    # reads exif and rotates images that havethis information
                    convert_options: { all: "-strip" }

  validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }

  def timestamp=(timestamp)
    self.committed_at = DateTime.strptime(timestamp.to_s,'%s')
  end
end
