require 'sp_api'

namespace :sp do
  desc "Fetch offers from SponsorPay's Mobile Offers API"
  task :fetch_offers => :environment do
    offers = SpApi.fetch_offers 'player1', 'custom', 1
    puts offers
  end
end