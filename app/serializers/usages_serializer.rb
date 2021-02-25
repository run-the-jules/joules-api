class UsagesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :kwh, :start_date, :end_date, :meter_id
end
