# Pocket to mail

## Local Test

Copy `.env.sample` to `.env`, fill it:

```shell
API_KEY=POCKET_CONSUMER_KEY
ACCESS_TOKEN=POCKET_USER_ACCESS_TOKEN
MAIL_ADDRESS=GMAIL_EMAIL
MAIL_PASSWORD=GMAIL_PASSWORD
```

You should go to [Pocket Developer API](https://getpocket.com/developer/apps/new) to get `API_KEY`.

You can use [pocket-ruby](https://github.com/turadg/pocket-ruby) to get `ACCESS_TOKEN`.

If your gmail account has set with two-factory, you should go to [](https://security.google.com/settings/security/apppasswords) to get the application password.

## Heroku

Go to [Heroku Dashboard](https://dashboard-preview.heroku.com/apps), in your heroku application setting page, config variables section, add variables with content of `.env`.

Set [Heroku scheduler](https://devcenter.heroku.com/articles/scheduler).
