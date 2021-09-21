require 'rails_helper'

RSpec.describe 'User dashboard page' do
  describe 'as an authenticated user' do

    before(:each) do
      json_response = File.read('spec/fixtures/user/user_info.json')
      stub_request(:get, "https://travel-buddy-api.herokuapp.com/api/v1/users/3112").to_return(status: 200, body: json_response, headers: {})

      json_response2 = File.read('spec/fixtures/trips/dashboard/trip_new.json')
      stub_request(:get, "https://travel-buddy-api.herokuapp.com/api/v1/trips/2064").to_return(status: 200, body: json_response2, headers: {})

      json_response3 = File.read('spec/fixtures/trips/dashboard/trip_new.json')
      stub_request(:get, "https://travel-buddy-api.herokuapp.com/api/v1/trips/2065").to_return(status: 200, body: json_response3, headers: {})

      json_response4 = File.read('spec/fixtures/trips/dashboard/trip_new.json')

      stub_request(:get, "https://travel-buddy-api.herokuapp.com/api/v1/trips/2066").to_return(status: 200, body: json_response4, headers: {})

      @user = UserFacade.current_user_info(3112)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/user_dashboard'
    end

    describe 'when I visit the "/user_dashboard" path' do

      it 'displays welcome message' do
        expect(current_path).to eq('/user_dashboard')
        expect(page).to have_content("Welcome #{@user.email}!")
      end

      it 'displays a button to explore national parks' do
        expect(page).to have_button("Explore National Parks")
      end

      # context 'when I click on the explore national parks button' do
      #   before { click_button('Explore National Parks') }
      #
      #   it 'redirects me to the explore page' do
      #     expect(current_path).to eq('/explore')
      #   end
      # end

      it 'displays a current trip section' do
        within "#current_trip" do
          expect(page).to have_content("Current Trip")
          @user.current_trips.each do |trip|
            expect(page).to have_link(trip[:name])
          end

          within("#current-trip-#{@user.current_trips[0][:id]}") do
            click_link @user.current_trips[0][:name]
          end

          expect(current_path).to eq("/trips/dashboard/#{@user.current_trips[0][:id]}")
        end
      end

      it 'displays an upcoming trips section' do
        within "#upcoming_trips" do
          expect(page).to have_content("Upcoming Trips")

          @user.upcoming_trips.each do |trip|
            expect(page).to have_link(trip[:name])
          end

          within("#upcoming-trip-#{@user.upcoming_trips[0][:id]}") do
            click_link @user.upcoming_trips[0][:name]
          end

          expect(current_path).to eq("/trips/dashboard/#{@user.upcoming_trips[0][:id]}")
        end
      end

      it 'displays a past trips section' do
        within "#past_trips" do
          expect(page).to have_content("Past Trips")

          @user.past_trips.each do |trip|
            expect(page).to have_link(trip[:name])
          end

          within("#past-trip-#{@user.past_trips[0][:id]}") do
            click_link @user.past_trips[0][:name]
          end

          expect(current_path).to eq("/trips/dashboard/#{@user.past_trips[0][:id]}")
        end
      end

      it 'displays a friends section' do
        within "#friends" do
          expect(page).to have_content("Friends")
          
          @user.friends.each do |friend|
            expect(page).to have_content(friend[:email])
          end
        end
      end
    end
  end
end
