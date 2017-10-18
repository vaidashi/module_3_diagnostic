
class SearchController < ApplicationController

  def index

    @conn = Faraday.new(url: "https://developer.nrel.gov/api/alt-fuel-stations/v1.json?api_key#{ENV["NREL_KEY"]}") do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    response = @conn.get("")

    stations_result = JSON.parse(response.body, symbolize_names: true)

    @stations = stations_result.map do |station|
      Station.new(station)
    end
  end

end
