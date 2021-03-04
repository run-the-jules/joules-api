class ApplicationController < ActionController::API
  def raise_not_found!
    render json: { error: "No route matches #{params[:unmatched_route]}. Though you may insist, this route does not exist." }.to_json,
           status: 404
  end
end
