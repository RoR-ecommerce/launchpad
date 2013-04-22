Environment Requirements
========================

Ruby
----

Current development version of Ruby is __2.0.0-p0__ or any minor version above.

Please make sure your Ruby version manager files are in global git ignores and
do not commit them to the repository.

Please use modern Ruby syntax that was introduced in 1.9+

Rails
-----

Current development version of Rails is __3.2.13__, however try to avoid any Rails
3 specific stuff so we'll have easier transition to __Rails 4__ once it come out.

Gemfile
-------

Always lock specific gems in production environment.

```ruby
gem 'rails', '3.2.13'
```

Development and test environments should have minimum requirements only if
necessary.

```ruby
gem 'rspec-rails', '~> 2.13.0'
```

Foreman
-------

Processes are managed by Foreman gem. Copy `Procfile.dev.example` to
`Procfile.dev` and edit for your needs. Make sure it is in your global gitignore
so you won't commit this file into repository.

You can Foerman with

```shell
foreman start -f Procfile.dev
```

Testing
=======

Stack

* RSpec
* FactoryGirl
* DatabaseCleaner
* Capybara

Install [PhantomJS](https://github.com/jonleighton/poltergeist#installing-phantomjs)
