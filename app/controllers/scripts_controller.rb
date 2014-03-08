class ScriptsController < ApplicationController
  layout false

  def capture_script
    render 'capture.rb.erb'
  end

  def background_capture_script
    render 'background_capture.rb.erb'
  end

  def imagesnap
    send_file 'vendor/imagesnap/imagesnap'
  end
end
