class Commit < ActiveRecord::Base
  belongs_to :board
  belongs_to :user

  has_many :comments, -> { order('created_at asc') }

  validates :project, :sha, :committed_at,
             presence: true
  validates :board_id, :user_id, presence: true

  has_attached_file :image,
                    styles: {medium: ['400x225#', :jpg]},
                    default_style: :medium,
                    # couldnt get this to work from paperclip_settings so have to apply to all models with image attachments..
                    # remove all exif information since ipad actually
                    # reads exif and rotates images that havethis information
                    convert_options: { all: "-strip" }

  validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] },
                               presence: true

  def to_param
    sha
  end

  def timestamp=(timestamp)
    self.committed_at = DateTime.strptime(timestamp.to_s,'%s')
  end

  def project
    github_path.present? ? github_path.split('/').last : super
  end

  def organization
    github_path.present? ? github_path.split('/').first : nil
  end
end
