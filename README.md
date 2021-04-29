# Initial Setup

Ruby version 3.0.1. Recommend to use `rvm`.

Run

```
gem install bundler
bundle install
```

## Database

This project uses MySQL. MySQL configuration can be set using `.env`.
Refer to `.env.sample`.


# Run Test

```
rspec
```


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
