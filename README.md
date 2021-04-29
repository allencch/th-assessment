# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Availability Model

Availability can be specified into OneoffAvailabity and RecurrentAvailability.

OneoffAvailability main attributes are

* start_at
* end_at

RecurrentAvailability main attributes are

* repeat_type - weekly, monthly, yearly?
* whole_day
* day - day of the month
* week_day - day of the week
* week_modifier - ordinal of the week, eg 1st, 2nd, 3rd, ... . Use together with repeat_type
* time_start - if not whole day
* time_end - if not whole day
