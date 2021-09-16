require 'rails_helper'

describe NationalParkService do
  context "class methods" do
    context ".some_api_endpoint_feature" do
      it "returns list of all parks" do
        parks = NationalParkService.all_parks
        expect(parks).to be_a Hash
        expect(parks[:data]).to be_an Array
        expect(parks[:data].size).to eq(465)

        park_data = parks[:data].first
        expect(park_data).to have_key :id
        expect(park_data[:id]).to be_an(String)

        expect(park_data).to have_key :url
        expect(park_data[:url]).to be_an(String)

        expect(park_data).to have_key :fullName
        expect(park_data[:fullName]).to be_a(String)

        expect(park_data).to have_key :images
        expect(park_data[:images]).to be_an(Array)
      end
    end

    context ".conn" do
      it "establishes connection with api service" do
        conn = NationalParkService.conn
        expect(conn).to be_a Faraday::Connection
        expect(conn.params.keys).to include('api_key')
        expect(conn.params['api_key']).to eq(ENV['nps_api_key'])
      end
    end
  end
end
