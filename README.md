A proof of concept about Single sign-on (SSO) options in Zendesk with Ruby on Rails and JWT gem

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.2.2

* Configuration
You must create a file "application.yml" on /config with the Zendesk keys "ZD_SUBDOMAIN" and "ZD_SSO_SECRET", in this way:

  development:
    ZD_SUBDOMAIN: "your zendkesk subdomain"
    ZD_SSO_SECRET: "your sso secret token"

see Figaro gem config.

* Database initialization
rails db:setup

* Deployment instructions
