class HotelController < ApplicationController
  def index
    query = Hotel.all
    query = query.where(destination_id: params[:destination_id]) if params[:destination_id]
    query = query.where(id: params[:id]) if params[:id]

    render json: query
  end
end
