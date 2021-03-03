class MeterActivationFacade
  class << self
    def fetch_utilities(params)
      UsageService.fetch_utilities
    end

    def new_user(params)
      data = UsageService.new_user(params)[:data][:url]
    end

    def referral(params)
      UsageService.get_meters(params[:referral])[:data]
    end

    def parse_meters(meters, id)
      unless meters.nil?
        usages = meters.flat_map do |meter|
          get_bills(meter[:meter_uid], id)
        end
      end
      usages
    end

    def get_bills(meter_uid, id)
      bills = UsageService.get_bills(meter_uid)[:data]
      if bills.class == Array
        usages = bills.map do |bill|
          create_usage(bill, id)
        end
      else
        nil
      end
      usages
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
