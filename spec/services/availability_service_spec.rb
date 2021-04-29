describe AvailabilityService do
  let(:user) { create(:user) }

  describe 'Creates availabilities' do
    it 'creates weekly availability' do
      AvailabilityService.create_recurrent_availability(
        user,
        week_day: 1 # Monday
      )
      user.reload
      expect(user.recurrent_availabilities.length).to eq(1)

      availability = user.recurrent_availabilities.first
      expect(availability.week_day).to eq(1)
      expect(availability.recurrent_start).to be_truthy
    end

    it 'creates one-off availability' do
      AvailabilityService.create_oneoff_availability(
        user,
        start_at: Time.zone.parse('2021-04-01'),
        end_at: Time.zone.parse('2021-04-02')
      )
      user.reload
      expect(user.oneoff_availabilities.length).to eq(1)

      availability = user.oneoff_availabilities.first
      expect(availability.start_at).to eq('2021-04-01')
      expect(availability.end_at).to eq('2021-04-02')
    end
  end

  describe 'Checks one-off availability' do
    it 'checks one-off availability' do
      AvailabilityService.create_oneoff_availability(
        user,
        start_at: Time.zone.parse('2021-04-01T08:00:00Z'),
        end_at: Time.zone.parse('2021-04-02T16:00.00Z')
      )

      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-01T08:00:00Z'))
      expect(result).to eq(true)

      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-01'))
      expect(result).to eq(false)
    end
  end

  describe 'Check recurrent availability' do
    it 'checks availability of every Monday' do
      AvailabilityService.create_recurrent_availability(
        user,
        week_day: 1
      )

      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-26'))
      expect(result).to eq(true)
      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-27'))
      expect(result).to eq(false)
    end

    it 'checks availability of every 2nd Tueday of the Month' do
      AvailabilityService.create_recurrent_availability(
        user,
        week_day: 2,
        week_modifier: 2, # second week
        repeat_type: :monthly
      )

      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-13')) # second Tuesday
      expect(result).to eq(true)
      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-14'))
      expect(result).to eq(false)
      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-20')) # 3rd Tuesday
      expect(result).to eq(false)
    end

    it 'checks availabilities of every Tuesday and Thursday' do
      AvailabilityService.create_recurrent_availability(
        user,
        week_day: 2
      )
      AvailabilityService.create_recurrent_availability(
        user,
        week_day: 4
      )
      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-13')) # Tuesday
      expect(result).to eq(true)
      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-14')) # Wednesday
      expect(result).to eq(false)
      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-15')) # Thursday
      expect(result).to eq(true)
      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-20')) # Tuesday
      expect(result).to eq(true)
      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-21')) # Wednesday
      expect(result).to eq(false)
      result = AvailabilityService.available?(user, Time.zone.parse('2021-04-22')) # Thursday
      expect(result).to eq(true)
    end
  end
end
