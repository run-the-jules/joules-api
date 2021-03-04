class Api::V1::GetMetersController < ApplicationController
  after_action :get_bills, only: [:index] do
    unless @skip_after_action
    end
  end
  def index
    if params[:referral].to_i != 0
      begin
        @meters = MeterActivationFacade.referral(params)
        render json: {error: "Your Meters have been pulled and bills are being generated, please check back in 15 minutes."}
      rescue
        @skip_after_action = true
        something_went_wrong
      end
    else
      @skip_after_action = true
      raise_not_found!
    end
  end

  private

  def get_bills
    if @skip_after_action 
      return nil
    else
      bills = MeterActivationFacade.parse_meters(@meters, params[:id])
      if bills.nil? || bills.first.nil?
        sleep 5
        get_bills
      end
    end
  end
end
