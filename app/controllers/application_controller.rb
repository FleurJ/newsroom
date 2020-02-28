class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def default_url_options
    { host: ENV["kiosk-ares.herokuapp.com"] || "localhost:3000" }
  end
end
