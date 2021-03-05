class Usage < ApplicationRecord
  validates :start_date, uniqueness: true
  validates :user_id, :kwh, :start_date, :end_date, :meter_id, presence: true
end
