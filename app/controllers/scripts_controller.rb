class ScriptsController < ApplicationController
  layout false

  def project_install
    render 'project_install.rb.erb'
  end

  def update
    render 'update.rb.erb'
  end
end