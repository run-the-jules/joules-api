class Api::V1::GetMetersController < ApplicationController
  after_action :get_bills, only: [:index]
  def index
    if params[:referral].to_i != 0
      begin
        @meters = MeterActivationFacade.referral(params)
        render json: {error: "Your Meters have been pulled and bills are being generated, please check back in 15 minutes."}
      rescue
        something_went_wrong
      end
    else
      raise_not_found!
    end
  end

  private

  def get_bills
    bills = MeterActivationFacade.parse_meters(@meters, params[:id])
    if bills.nil? || bills.first.nil?
      sleep 5
      get_bills
    end
  end
end
