class Api::V1::MeterActivationController < ApplicationController

  def index
    if params[:meter_uid]
      bills = MeterActivationFacade.get_bills(params[:meter_uid])
    else
      fetch_info = MeterActivationFacade.fetch_usages(params)
    end
  end
end