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
  end
end
