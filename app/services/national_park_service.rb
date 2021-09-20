class NationalParkService
  class << self
    def all_parks
      response = conn.get('parks') do |req|
        req.params['limit'] = 465
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    def parks_by_state(state_code)
      response = conn.get("parks?statecode=#{state_code}")

      body = JSON.parse(response.body, symbolize_names: true)
    end

    def parks_by_activity(activity)
      response = conn.get("activities/parks?q=#{activity}")

      body = JSON.parse(response.body, symbolize_names: true)
    end
  end


  def self.conn
    Faraday.new(url: 'https://developer.nps.gov/api/v1/') do |req|
      req.headers['X-Api-Key'] = ENV['nps_api_key']
    end
  end
end
