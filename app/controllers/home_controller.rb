class HomeController < ApplicationController
  def index
    @cities = Location.all(select: :city).map(&:city).sort
    @services = Service.all(select: 'name, code').sort_by(&:name).map{|s| [s.name, s.code]}
  end
end