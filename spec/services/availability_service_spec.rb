describe AvailabilityService do
  let(:user) { create(:user) }

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
