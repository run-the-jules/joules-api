class UsagesFacade
  class << self
    def utility_info(id)
      create_usage(id)
    end

    private 

    def create_usage(id)
      data = fetch_info(id)
      Usage.create(user_id: data[:user_uid], 
                  kwh: data[:readings][:kwh], 
                meter_id: data[:meter_id], 
                start_date: data[:readings][:start],
                end_date: data[:readings][:end])
    end

    def fetch_info(params)
      endpoint = "/api/v1/users/#{params}/usage"
      UsageService.kwh_usage(endpoint)
    end
  end
end
