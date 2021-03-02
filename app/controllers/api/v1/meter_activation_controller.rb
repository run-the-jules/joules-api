class Api::V1::MeterActivationController < ApplicationController
  def index
    if params[:meter_uid]
      MeterActivationFacade.get_bills(params[:meter_uid])
      render json: {message: 'fetching bills'}, status: 202
    elsif params[:email] && params[:utility]
      render json: MeterActivationFacade.new_user(params)
    elsif params[:referral]
      render json: MeterActivationFacade.referral(params)
    elsif params[:utilities]
      render json: MeterActivationFacade.fetch_utilities(params)
    else
      render json: { error: 'bad request'}, status: 404
    end
  end


  # def new_user
  #   render json: MeterActivationFacade.new_user(params)
  # end

  # def referral
  #   render json: MeterActivationFacade.referral(params)
  # end
end