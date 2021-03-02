class Api::V1::GetMetersController < ApplicationController
  def index
    render json: MeterActivationFacade.referral(params)
  end
end