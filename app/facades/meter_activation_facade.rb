class MeterActivationFacade
  class << self
    def referral(params)
      data = UsageService.get_meters(params[:referral])[:data]
      sleep 20
      unless data.nil?
        data.each do |meter|
          get_bills(meter[:meter_uid])
        end
      end
      data
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
