# TODO: move to an initializer?
require 'sp_api'

class OffersController < ApplicationController
  def index
    @offers = []
    if request.post?
      if params[:uid].empty? || params[:pub0].empty? || params[:page].empty?
        flash[:alert] = "Please fill all the form fields"
      else
        begin
          # TODO: use a dropdown for page param? can be updated according to the 'pages' param returned by api..
          page = params[:page].to_i
          page = page < 1 ? 1 : page
          @offers = SpApi.fetch_offers params[:uid], params[:pub0], page
        rescue Exception => e
          if Rails.env.production?
            flash[:alert] = "Sorry, an API error occurred"
          else
            flash[:alert] = "An API error occurred: #{e.message}"
          end
        end
      end
    else
      flash.clear
    end
  end
end
