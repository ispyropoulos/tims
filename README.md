# TIMS app

A Rails 5 web application for displaying TFL (Transport for London) Live Traffic
Disruptions (LTIS) visually, using a local API endpoint for efficient consumption
of the [TIMS](https://api-portal.tfl.gov.uk/docs) real-time feed.

#### Web views

Currently, there is only one view, which displays the live disruption points on
a Google map. This view is accesible at `/disruptions`. The map is updated
automatically at a 30 second interval.

#### API

There is one available API endpoint at `/api/v1/disruptions` that responds with
a JSON array of the Latitude/Longitude coordinates of the disruption points. The
endpoint provides a 5 minute cache for speedy requests.

## Ruby version

You will need MRI Ruby 2.3.1 to run this application. If you use RVM, do the
following, to install the appropriate Ruby version and create a seperate gemset,
for neatness:

```ruby
rvm install ruby-2.3.1
rvm use 2.3.1@tims --ruby-version --create
```

## System dependencies

There are some dependencies on third party libraries. These automatically installed
as gems via Bundler. Just do:

```bash
gem install bundler
bundle install
```

Here is a brief summary of these dependencies:

There are some libraries used in tests only,

- `minitest-rails` - Minitest integration for Rails.
- `minitest-reporters` - MiniTest output format customisation.
- `webmock` - HTTP stubbing library.

## Environment variables

You need to set up the following environment variables:

`GOOGLE_API_KEY` and, if for any reason you need to override it, the `TIMS_FEED_URL`.
The default value for the latter will be
`'https://data.tfl.gov.uk/tfl/syndication/feeds/tims_feed.xml'`.

## No database setup required

This application does not need any database configuration. You are good to go.

## How to run the test suite

To run the complete test suite, do

```bash
rake test
```

## Cache store

This application uses the low-level caching features of Rails. In order to enable
this for `development` please add a `caching-dev.txt` file under the `/tmp` path.
Done! Nothing else is required.

On production, we need to configure our cache store's underlying adapter. For the
purposes of this project we just use the default one, which uses the server's RAM.

## License

TIMS app is released under the
[MIT License](https://github.com/ispyropoulos/tims/blob/master/LICENSE).
