# TikTak

Check out a demo of the latest stable build on
[Heroku](http://acb-api.herokuapp.com/).

## About

TikTak provides a light-weight, Yik Yak-like anonymous forum system with
BBS-style assets including user sign-up, private messaging, quoting,
hellbanning, IP whitelisting / blacklisting / caching, post reporting,
and an easy-to-use moderation system.

## Deploying

Site-wide globals, e.g. the name of your campus or institution, are
stored in `config/settings.yml` and accessed with the Settings object.

TikTak is deployed with Heroku using sendgrid for mailer integration
by default.

## License

TikTak is released under the [MIT License](/LICENSE).
