
class SearchController < ApplicationController

  def index


    @stations = stations_result.map do |station|
      Station.new(station)
    end
  end

end
