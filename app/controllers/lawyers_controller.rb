class LawyersController < ApplicationController

  def index
    @cities = Location.all(select: :city).map(&:city).sort
    @services = Service.all(select: 'name, code').sort_by(&:name).map{|s| [s.name, s.code]}

    @lawyers = Lawyer.search do
      data_accessor_for(Lawyer).include = [:location, :services]

      with :city, params[:city] if params[:city].present?
      with :service_codes, Array(params[:service_code]) if params[:service_code].present?

      order_by :average_rating, :desc
      paginate :page => params[:page], :per_page => 10
    end.results
  end

  def show
    @lawyer = Lawyer.find(params[:id])
  end
end
