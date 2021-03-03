class MeterActivationFacade
  class << self
    def fetch_utilities(params)
      UsageService.fetch_utilities
    end

    def new_user(params)
      data = UsageService.new_user(params)[:data][:url]
    end

    def referral(params)
      data = UsageService.get_meters(params[:referral])[:data]
      sleep 30
      unless data.nil?
        data.each do |meter|
          get_bills(meter[:meter_uid], params[:id])
        end
      end
      data
    end

    def get_bills(meter_uid, id)
      bills = UsageService.get_bills(meter_uid)[:data]
      bills.map do |bill|
        create_usage(bill, id)
      end
    end

    private

    def create_usage(data, id)
      Usage.create(user_id: id,
                   kwh: data[:kwh],
                   meter_id: data[:meter_uid],
                   start_date: data[:start_date],
                   end_date: data[:end_date])
    end
  end
end
