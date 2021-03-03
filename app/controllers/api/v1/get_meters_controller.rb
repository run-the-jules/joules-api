class Api::V1::GetMetersController < ApplicationController
  def index
    if params[:referral].to_i != 0
      render json: MeterActivationFacade.referral(params)
    else
      raise_not_found!
    end
  end
end
