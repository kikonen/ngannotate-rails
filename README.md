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

### Environment options

- NG_REGEXP
  * regexp passed to ng-annoate
  * see ng-annotate documentation
- NG_OPT
  * comma separate list of "opt=value" key pairs passed as options to ng-annotate
  * see ng-annotate documentation
- NG_FORCE
  * force ng-annoate processing in development/test environment

For example,

    # Test assets compile in rails development environment
    # (assuming config/environments/development.rb is adjusted approriately)

    # with rails 3.2
    NG_FORCE=true RAILS_ENV=development bundle exec rake assets:clean assets:precompile

    # with rails 4.1
    NG_FORCE=true RAILS_ENV=development bundle exec rake assets:clobber assets:precompile


### Rails configuration options

Defined in "config.ng_annotate"

- process
  * Is annotation processing done for current environment (NG_FORCE=true takes precedence over this)
  * default: true for production, false for development and test
- options
  * Options for ngannotate (NG_OPT takes precedence over this)
  * default: {}
- regexp
  * regexp option for ngannotate (NG_REGEXP takes precedence over this)
  * default: nil
- ignore_paths
  * List of asset paths, which are ignored from ngannotate processing
  * default: ["/vendor/"]

For example,

config/environments/development.rb

    Rails.application.configure do
    ...
        config.ng_annotate.process = true
        config.ng_annotate.options = {
          key1: 'value',
          key2: 'value',
        }
        config.ng_annotate.regexp = "xxx"
        config.ng_annotate.ignore_paths = [
          '/vendor/',
          'some/path',
        ]
    ...
    end


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

Release Process
---------------

For ngannotate update:

```bash
git checkout master
git pull
rake ngannotate:build
git citool
# check that result makes sense and if so,
# use comment: ngannotate: vX.Y.Z
git tag vX.Y.Z
git push
git push --tags
gem build ngannotate-rails.gemspec
gem push ngannotate-rails-X.Y.Z.gems
```

For internal fixes:

Similar except no ngannotate:build and new version is previous plus fourth digit for patch level (see Versioning).


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
