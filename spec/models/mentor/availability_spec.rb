# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mentor::Availability, type: :model do
  let(:mentor_profile) { create(:mentor_profile) }

  describe 'associations' do
    it { is_expected.to belong_to(:mentor_profile).class_name('Mentor::Profile').inverse_of(:availabilities) }
    it { is_expected.to have_many(:bookings).class_name('Client::Booking').dependent(:restrict_with_error) }
  end

  describe 'validations' do
    subject { build(:mentor_availability, mentor_profile: mentor_profile) }

    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }

    context 'when end_time is before start_time' do
      it 'is not valid' do
        availability = build(:mentor_availability,
                             mentor_profile: mentor_profile,
                             start_time: 2.hours.from_now,
                             end_time: 1.hour.from_now)
        expect(availability).not_to be_valid
      end

      it 'adds an error to end_time when it is before start_time' do
        availability = build(:mentor_availability,
                             mentor_profile: mentor_profile,
                             start_time: 2.hours.from_now,
                             end_time: 1.hour.from_now)
        availability.valid?
        expect(availability.errors[:end_time]).to include('deve ser posterior ao horário de início')
      end
    end

    context 'when times overlap for the same mentor' do
      before do
        create(:mentor_availability,
               mentor_profile: mentor_profile,
               start_time: 1.hour.from_now,
               end_time: 2.hours.from_now)
      end

      it 'is not valid' do
        availability = build(:mentor_availability,
                             mentor_profile: mentor_profile,
                             start_time: 1.hour.from_now,
                             end_time: 2.hours.from_now + 1.hour)

        expect(availability).not_to be_valid
      end

      it 'adds an error to base when times overlap' do
        availability = build(:mentor_availability,
                             mentor_profile: mentor_profile,
                             start_time: 1.hour.from_now,
                             end_time: 2.hours.from_now + 1.hour)
        availability.valid?
        expect(availability.errors[:base]).to include('Já existe uma disponibilidade cadastrada nesse período')
      end
    end
  end

  describe 'scopes' do
    let!(:available) { create(:mentor_availability, mentor_profile: mentor_profile, booked: false, start_time: 1.day.from_now, end_time: 1.day.from_now + 1.hour) }
    let!(:booked) { create(:mentor_availability, mentor_profile: mentor_profile, booked: true, start_time: 2.days.from_now, end_time: 2.days.from_now + 1.hour) }
    let!(:past) { create(:mentor_availability, mentor_profile: mentor_profile, booked: false, start_time: 1.day.ago, end_time: 1.day.ago + 1.hour) }

    describe '.available' do
      it 'includes availabilities that are not booked' do
        expect(described_class.available).to include(available, past)
      end

      it 'does not include availabilities that are booked' do
        expect(described_class.available).not_to include(booked)
      end
    end

    describe '.upcoming' do
      it 'includes availabilities in the future' do
        expect(described_class.upcoming).to include(available, booked)
      end

      it 'does not include past availabilities' do
        expect(described_class.upcoming).not_to include(past)
      end
    end

    describe '.within_range' do
      it 'includes availabilities within the given range' do
        range_start = 1.day.from_now
        range_end = 3.days.from_now
        expect(described_class.within_range(range_start, range_end)).to include(available, booked)
      end

      it 'does not include availabilities outside the given range' do
        range_start = 1.day.from_now
        range_end = 3.days.from_now
        expect(described_class.within_range(range_start, range_end)).not_to include(past)
      end
    end
  end

  describe '#duration_in_minutes' do
    it 'returns the correct duration in minutes' do
      availability = build(:mentor_availability,
                           start_time: Time.current,
                           end_time: 90.minutes.from_now)
      expect(availability.duration_in_minutes).to eq(90)
    end

    it 'returns 0 if start_time is nil' do
      expect(build(:mentor_availability, start_time: nil).duration_in_minutes).to eq(0)
    end

    it 'returns 0 if end_time is nil' do
      expect(build(:mentor_availability, end_time: nil).duration_in_minutes).to eq(0)
    end
  end
end
