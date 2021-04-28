class Availability < ApplicationRecord
  enum repeat_type: { no_repeat: :no_repeat, weekly: :weekly, monthly: :monthly }
end
