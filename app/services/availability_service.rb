module AvailabilityService
  def self.create_recurrent_availability(
        user,
        repeat_type: :weekly,
        whole_day: true,
        day: nil, # day of the month
        week_day: nil,
        week_modifier: nil,
        time_start: nil,
        time_end: nil,
        recurrent_start: nil,
        recurrent_end: nil
      )
    user.recurrent_availabilities.create(
      repeat_type: repeat_type,
      whole_day: whole_day,
      day: day,
      week_day: week_day,
      week_modifier: week_modifier,
      time_start: time_start,
      time_end: time_end,
      recurrent_start: recurrent_start || Time.now,
      recurrent_end: recurrent_end
    )
  end

  def self.create_oneoff_availability(
        user,
        start_at: nil,
        end_at: nil
      )
    user.oneoff_availabilities.create(
      start_at: start_at || Time.now,
      end_at: end_at || Time.now + 2.hours
    )
  end

  def self.available?(user, datetime)
    !oneoff_availabilities(user, datetime).empty? ||
      !recurrent_availabilities(user, datetime).empty?
  end

  def self.oneoff_availabilities(user, datetime)
    user.oneoff_availabilities
      .where(
        'start_at <= :datetime
          AND (end_at IS NULL OR end_at >= :datetime)',
        datetime: datetime
      )
  end

  def self.recurrent_availabilities(user, datetime)
    # TODO: Refactor to availability scope
    user.recurrent_availabilities
      .where(
        '(repeat_type = "weekly" AND week_day + 1 = DAYOFWEEK(:datetime))
         OR
         (repeat_type = "monthly"
            AND week_day + 1 = DAYOFWEEK(:datetime)
            AND (
              IF(week_modifier IS NOT NULL,
                FLOOR((DAYOFMONTH(:datetime) - 1) / 7) + 1 = week_modifier,
                1
              )
            )
         )',
        datetime: datetime
      )
  end
end
