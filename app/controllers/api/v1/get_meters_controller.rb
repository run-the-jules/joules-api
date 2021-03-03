class Api::V1::GetMetersController < ApplicationController
  def index
    if params[:referral].to_i == 0
      render json: { 'error' => 'referral does not exist' }, status: 400
    else
      render json: MeterActivationFacade.referral(params)
    end
  end
end