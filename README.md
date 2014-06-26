## SponsorPay Mobile Offers API - Ruby Developer Challenge

Simple rails 4 app that fetches and displays offers using [SponsorPay's Mobile Offers API](http://developer.sponsorpay.com/content/ios/offer-wall/offer-api/).

### Ruby version

Developed on ruby-2.1.2, though ruby >= 1.9.3 should work just fine. *Note: To change the ruby version edit the .ruby-version file.*

### Rails version

Rails 4.1.1

### Dependencies

* Ruby
* Bundler
* RVM - for ruby switching (or some other tool that uses .ruby-version for switching ruby versions)

### Setting up

* Clone/download the code.
* Change into the directory and run `bundle install`

NOTE: This app requires a valid SponsorPay API key. You may update it in the main application config file (`config/application.rb`) or have it available in the rails environment variables using the key `SP_API_KEY`.

### How to run the site

In development, if you've updated the API key in `config/application.rb`, simply run `rails server`. If not, run `SP_API_KEY=YOUR_API_KEY rails server`.

If running in production, probably best to save the environment variable in your server's configuration using the key `SP_API_KEY`.

### Running tests

If you've updated the API key in `config/application.rb`, simply run `rake test`. If not, run `SP_API_KEY=YOUR_API_KEY rake test`.

You can also test the offers api directly using a rake task that's been provided: `rake sp:fetch_offers` or `SP_API_KEY=YOUR_API_KEY rake sp:fetch_offers`.

To use different parameters for the rake task, edit the rake file directly at `lib/tasks/sp.rake`.