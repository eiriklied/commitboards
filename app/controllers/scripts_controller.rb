class ScriptsController < ApplicationController
  layout false

  def project_install
    render 'project_install.rb.erb'
  end

  def capture_script
    render 'capture.rb.erb'
  end

  def imagesnap
    send_file 'vendor/imagesnap/imagesnap'
  end
end