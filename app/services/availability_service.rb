module AvailabilityService
  def self.create_recurrent_availability(
        user,
        repeat_type: :weekly,
        whole_day: true,
        day: nil, # day of the month
        week_day: nil,
        week_modifier: nil,
        time_start: nil,
        time_end: nil
      )
    user.recurrent_availabilities.create(
      repeat_type: repeat_type,
      whole_day: whole_day,
      day: day,
      week_day: week_day,
      week_modifier: week_modifier,
      time_start: time_start,
      time_end: time_end
    )
  end
end
