
class SearchController < ApplicationController

  def index

    @conn = Faraday.new(url: "https://api.data.gov") do |faraday|
      faraday.headers['X-Api-Key'] = ENV["NREL_KEY"]

      faraday.adapter Faraday.default_adapter
    end

    nearest_stations_response = @conn.get("/nrel/alt-fuel-stations/v1/nearest.json?fuel_type=LPG,ELEC&location=80203&radius=6&limit=10")
    stations_result = JSON.parse(nearest_stations_response.body, symbolize_names: true)[:fuel_stations]



    @stations = stations_result.map do |station|
      Station.new(station)
    end
  end

end
