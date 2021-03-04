class ApplicationController < ActionController::API
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, :with => :raise_not_found!
  end

  def raise_not_found!
    render json: { error: "No route matches #{params[:unmatched_route]}. Though you may insist, this route does not exist."}.to_json, status: 404
  end

  def something_went_wrong
    render json: { error: "Something went wrong.  Please try again later."}, status: 404
  end

  def bills_arent_ready
    render json: { error: "Your bills aren't ready yet. Please try again later."}, status: 404
  end
end
