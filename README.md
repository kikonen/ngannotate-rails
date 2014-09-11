ngannotate-rails
===========

Use <https://github.com/olov/ng-annotate> in the Rails asset pipeline.

Installation
------------

Add this line to your application's Gemfile:

    gem 'ngannotate-rails'

And then execute:

    $ bundle

That's it! ngannotate-rails integrates seamlessly into the Rails asset pipeline; your JavaScript or CoffeeScript assets will automatically be run through the ng-annotate pre-minifier.

Usage
-----

By default ng-annotate processing is disabled in development and test environments. Processing, however, can be enforced by specifying NG_FORCE=true option.


Options available as environment variables:

    NG_REGEXP     - regexp passed to ng-annoate
                    see ng-annotate documentation
    NG_OPT        - comma separate list of "opt=value" key pairs passed as options to ng-annotate
                    see ng-annotate documentation
    NG_FORCE=true - force ng-annoate processing in development/test environment


Examples,

    # Test assets compile in rails development environment
    # (assuming config/environments/development.rb is adjusted approriately)
    NG_FORCE=true RAILS_ENV=development bundle exec rake assets:clean assets:precompile


Testing assets locally
----------------------

To allow testing precompiled assets locally in development environment.

config/environments/development.rb

    #
    # to allow testing assets:precompile in development environment
    # Usage:
    #   time NG_FORCE=true RAILS_ENV=development bundle exec rake assets:clean assets:precompile:primary
    #   NG_FORCE=true rails s -p 3001
    #
    if ENV['NG_FORCE'] == 'true'
      config.assets.compress = true
      config.assets.compile = false
      config.assets.digest = true
      config.assets.debug = false
    end

precompile & start server

    time NG_FORCE=true RAILS_ENV=development bundle exec rake assets:clean assets:precompile:primary
    NG_FORCE=true rails s -p 3001


Versioning
----------

The ngannotate-rails version number mirrors the version number for the version of ng-annotate that is bundled with it.
For minor patch releases, when ng-annotate version is not changing, 4th digit is used (For example, "0.9.6.1").
Every released version is tagged with tag "v[VERSION]".

Help
----

  * **Q**: I installed ngannotate-rails, but my assets aren't getting processed with ng-annotate.

    **A:** Remember to delete `tmp/cache/assets` or `touch` all the related asset files so that the cached versions get regenerated. If you've precompiled your assets into `public/assets`, you'll need to re-precompile them.

Hacking
-------

### Upgrading ng-annotate

The actual ngannotate project is bundled into this gem via [Browserify](https://github.com/substack/node-browserify). You can update to the latest version of ng-annotate via Rake:

    rake ngannotate:build

### Test Application

There is a Rails 3 application bundled in `example/` that you can use to test the asset pipeline integration. Don't forget to remove `tmp/cache/assets` after upgrading to the latest version of ng-annotate.

Credits
-------

This gem is based into https://github.com/jasonm/ngmin-rails
