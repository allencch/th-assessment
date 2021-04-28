class RecurrentAvailability < Availability
  after_initialize do |availability|
    availability.repeat_type ||= :weekly
  end
end
