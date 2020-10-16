# Capital Science

#### Requirements

You'll need the following installed to run the template successfully:

* Ruby 2.6 or higher
* bundler - `gem install bundler`
* Redis - For ActionCable support (and Sidekiq, caching, etc)
* PostgreSQL - `brew install postgresql`
* Imagemagick - `brew install imagemagick`
* Yarn - `brew install yarn` or [Install Yarn](https://yarnpkg.com/en/docs/install)
* Foreman (optional) - `gem install foreman` - helps run all your
  processes in development
* [Stripe CLI](https://stripe.com/docs/stripe-cli) for Stripe webhooks in development - `brew install stripe/stripe-cli/stripe`

#### Running

If you're using foreman: `foreman start`

Otherwise, you'll need to spin up several processes in different
terminals:

```bash
rails server

# Your background workers
sidekiq # or whatever you're using

# Optionally, the webpack dev server for automatically reloading JS and CSS changes
bin/webpack-dev-server

# Stripe requires webhooks for SCA payments
stripe listen --forward-to localhost:5000/webhooks/stripe
```
