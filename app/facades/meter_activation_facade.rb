class MeterActivationFacade
  class << self
    def new_user(params)
      UsageService.new_user(params)
    end

    def referral(params)
      if params[:referral].to_i != 0
        UsageService.get_meters(params[:referral])[:data]
      else
        nil
      end
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
        usages
      else
        nil
      end
    end

    private

    def create_usage(data, id)
      Usage.find_or_create_by(user_id: id,
                   kwh: data[:kwh],
                   meter_id: data[:meter_uid],
                   start_date: data[:start_date],
                   end_date: data[:end_date])
    end
  end
end
