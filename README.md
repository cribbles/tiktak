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
- E-mail authentication
- Password resets
- Private messaging
- Post quoting
- Hellbanning
- IP whitelisting / blacklisting / caching
- Post reporting
- A straight-forward moderation system

## Deploying

Site-wide globals, e.g. the name of your campus or institution, are stored in
[`config/settings.yml`](./config/settings.yml) and accessed through the Settings
model.

TikTak uses user mailers (for sign-in / sign-up / lost password) and reCAPTCHA
(for spam control). You'll need to get these set up for production.

I deployed mailers with Heroku using Sendgrid. If you configuration is
different, you'll need to change your settings in
`config/environments/production.rb`.

## Notes

### Private Messaging

TikTak is fully anonymous, so private messaging works differently than on most
social platforms.

Anyone who's signed in has the ability to make themselves available for contact
by other registered users. When you send someone a private message, you can
offer to exchange e-mails through the application's handshake system. If they
accept, the e-mails for both sender and recipient will be revealed to each
other.

In production, you'll definitely want to provide an e-mail regex specific to
your campus / institution / organization in
[`config/settings.yml`](./config/settings.yml). This helps to ensure integrity
among contactees. The principle behind exchanging e-mails is that only
individuals who have authenticated through a 'my-cool-school.edu' account should
be available for contact. (Of course, this says nothing about who _in
particular_ a user might be getting in contact with.)

### Hellbanning

TikTak provides an implementation of
[hellbanning](https://en.wikipedia.org/wiki/Stealth_banning) (also known as
shadowbanning on some sites).

The conventional practice for hellbanning is to make a registered user's posts
only available to themselves. Because TikTak is anonymous and allows anyone to
post - with or without an account - this won't do. Instead, hellbanning is done
by IP address. A user posting from a hellbanned IP address can view all posts
made by themselves and other hellbanned users, but nobody else can see their
posts.

Hellbanning is tightly coupled to the topic index and show views, to the point
of paginating these views separately for hellbanned and non-hellbanned users.
This way, hellbanned users can appear to be bumping their own and others'
threads, but replying to a thread from a hellbanned IP address won't bump it for
the rest of the site.

## License

TikTak is released under the [MIT License](/LICENSE).

---
Developed by [Chris Sloop](http://chrissloop.com/)
