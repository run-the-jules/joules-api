class MeterActivationFacade
  class << self

    def fetch_usages(params)
      if params[:utilities]
        UsageService.fetch_utilities
      elsif params[:email] && params[:utility]
        UsageService.new_user(params)
      elsif params[:referral]
        data = UsageService.get_meters(params[:referral])[:data]
        data[:meters].flat_map do |meter|
          get_bills(meter)
        end
      end
    end

    def get_bills(meter_uid)
      bills = UsageService.get_bills(meter_uid)[:data]
      bills.map do |bill|
        create_usage(bill)
      end
    end

    private 

    def create_usage(data)
      Usage.create(user_id: data[:user_uid], 
                  kwh: data[:kwh], 
                  meter_id: data[:meter_uid], 
                  start_date: data[:start_date],
                  end_date: data[:end_date])
    end
  end
end
