class ScriptsController < ApplicationController
  skip_before_filter :require_login
  layout false

  def capture_script
    render 'capture.rb.erb'
  end

  def background_capture_script
    render 'background_capture.rb.erb'
  end

  def update_and_capture_script
    render 'update_and_capture.rb.erb'
  end

  def imagesnap
    send_file 'vendor/imagesnap/imagesnap'
  end

  def version
    render text: files_hash
  end

  def install
    @user_board = UserBoardToken.find_by key: params[:token]
    @board = @user_board.board
    render 'project_install.rb.erb', content_type: :text_plain
  end

private
  def files_hash
    scripts = [
      "#{Rails.root}/app/views/scripts/capture.rb.erb",
      "#{Rails.root}/app/views/scripts/background_capture.rb.erb",
      "#{Rails.root}/app/views/scripts/update_and_capture.rb.erb",
      "#{Rails.root}/vendor/imagesnap/imagesnap"]

    md5_for_all = scripts.map { |s| Digest::MD5.file(s).hexdigest }.join('')

    Digest::MD5.hexdigest(md5_for_all)
  end
end
