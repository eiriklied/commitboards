class ScriptsController < ApplicationController
  layout false

  def capture_script
    render 'capture.rb.erb'
  end

  def imagesnap
    send_file 'vendor/imagesnap/imagesnap'
  end
end