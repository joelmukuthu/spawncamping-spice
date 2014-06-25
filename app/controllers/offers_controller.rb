# TODO: move to an initializer?
require 'sp_api'

class OffersController < ApplicationController
  def index
    @offers = []
    if params[:commit]
      if params[:uid].empty? || params[:pub0].empty? || params[:page].empty?
        @fields_unfilled = true
      else
        begin
          page = params[:page].to_i
          page = page < 1 ? 1 : page
          @offers = SpApi.fetch_offers params[:uid], params[:pub0], page
        rescue Exception => e
          @api_error = e.message
        end
      end
    end
  end
end
