# TODO: move to an initializer?
require 'sp_api'

class OffersController < ApplicationController
  def index
    @offers = []
    if request.post?
      if params[:uid].blank? || params[:pub0].blank? || params[:page].blank?
        flash[:alert] = "Please fill all the form fields"
      else
        begin
          flash.clear
          # TODO: use a dropdown for page param? can be updated according to the 'pages' param returned by api..
          page = params[:page].to_i
          params[:page] = page < 1 ? 1 : page
          @offers = SpApi.fetch_offers params[:uid], params[:pub0], params[:page]
        rescue Exception => e
          if Rails.env.development?
            flash[:alert] = "An API error occurred: #{e.message}"
          else
            flash[:alert] = "Sorry, an API error occurred"
          end
        end
      end
    else
      flash.clear
    end
  end
end
