# TikTak

[Live](http://acb-api.herokuapp.com/).

## Summary

TikTak provides a light-weight, Yik Yak-like anonymous forum system with
BBS-style assets.

## Languages:

- Ruby
- Javascript
- HTML/CSS

## Frameworks:

- Rails 4
- SASS

## Libraries and Technologies:

- jQuery
- will_paginate
- Rack::Attack
- SettingsLogic
- [Faker::YikYak](https://github.com/cribbles/faker-yikyak)
- reCAPTCHA

## Test Suite

- Rspec
- FactoryGirl
- Capybara

## Features

- Secure, hand-rolled Rails user auth
- Private messaging
- Post quoting
- Hellbanning
- IP whitelisting / blacklisting / caching
- Post reporting
- A straight-forward moderation system

## Deploying

Site-wide globals, e.g. the name of your campus or institution, are stored in
`config/settings.yml` and accessed through the Settings model.

TikTak uses user mailers (for sign-in / sign-up / lost password) and reCAPTCHA
(for spam control). You'll need to get these set up for production.

I deployed mailers with Heroku using Sendgrid. If you configuration is
different, you'll need to change your settings in
`config/environments/production.rb`.

## License

TikTak is released under the [MIT License](/LICENSE).

---
Developed by [Chris Sloop](http://chrissloop.com/)
