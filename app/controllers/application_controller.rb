class ApplicationController < ActionController::API
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, :with => :raise_not_found!
  end

  def raise_not_found!
    render json: { error: "No route matches #{params[:unmatched_route]}. Though you may insist, this route does not exist."}.to_json, status: 404
  end
end
