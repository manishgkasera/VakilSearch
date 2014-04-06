class HomeController < ApplicationController
  def index
    @cities = Location.all(select: :city).map(&:city)
    @services = Service.all(select: 'name, code').map{|s| [s.name, s.code]}
  end
end