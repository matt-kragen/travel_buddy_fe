require 'rails_helper'

RSpec.describe AccommodationFacade do
  describe 'accommodation creation' do
    it 'can create accommodations based off of trip id' do
      json_response = File.read('spec/fixtures/accommodations/accommodations_by_trip.json')
      stub_request(:get, 'https://travel-buddy-api.herokuapp.com/api/v1/trips/39/accommodations').to_return(status: 200, body: json_response)

      accommodations = AccommodationFacade.create_accommodations_for_trip(39)

      expect(accommodations.count).to eq(2)

      accommodations.each do |accommodation|
        expect(accommodation).to be_a(Accommodation)
      end
    end

    it 'can create accommodation based off of trip and accommodation id' do
      json_response = File.read('spec/fixtures/accommodations/single_accommodation.json')
      stub_request(:get, 'https://travel-buddy-api.herokuapp.com/api/v1/trips/39/accommodations/7').to_return(status: 200, body: json_response)

      accommodation = AccommodationFacade.create_accommodation_by_id(39, 7)

      expect(accommodation.name).to eq('Belgrade')
      expect(accommodation.location).to eq('Rakaposhi')
      expect(accommodation.details).to eq('Whiteboards are white because Chuck Norris scared them that way.')
    end

    it 'can create a new accommodation for a trip'

    it ''
  end
end