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


### NOTES

#### Javascript runtime

[Issue with OSX javascript runtime](https://github.com/kikonen/ngannotate-rails/issues/20)

Use "therubyracer" as javascript runtime

Gemfile
```ruby
gem 'therubyracer',  platforms: :ruby
```


#### Heroku
[Issue with Heroku](https://github.com/kikonen/ngannotate-rails/issues/10)

When pushing to heroku its important to invalidate all of your assets.


```ruby
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.version = '1.1
```

### Environment options

- NG_REGEXP
  * regexp passed to ng-annotate
  * see ng-annotate documentation
- NG_OPT
  * comma separate list of "opt=value" key pairs passed as options to ng-annotate
  * see ng-annotate documentation
- NG_FORCE
  * force ng-annotate processing in development/test environment

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
  * Options for ngannotate (NG_OPT and NG_REGEXP env variables take precedence over this)
  * default: {}
- paths
  * Asset paths, which are handled. Paths in ignore_paths override this setting
    Values can be [String | Regexp | Proc] instances
  * default: [/.*/]
- ignore_paths
  * List of asset paths, which are ignored from ngannotate processing.
    Values can be [String | Regexp | Proc] instances
  * default: ['/vendor/']

For example,

config/environments/development.rb

    Rails.application.configure do
    ...
        config.ng_annotate.process = true
        config.ng_annotate.options = {
          key1: 'value',
          regexp: '...',
        }
        config.ng_annotate.paths = [
          Rails.root.to_s,
        ]
        config.ng_annotate.ignore_paths = [
          '/vendor/',
          '/some/path/'
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

Originally version numbering of this gem followed ng-annotate. However, in order to improve
handling of possibly compatibility breaking fixes and improvements, version schema is now
separated from ng-annotate. Instead of matching versions, changelog in
[wiki](https://github.com/kikonen/ngannotate-rails/wiki) will indicate which is currently matching
ng-annotate version.

Every released version is tagged with tag "vX.Y.Z".

Release Process
---------------

For ngannotate update (or any other improvements/fixes):

```bash
git checkout master
git pull
# if ngannotate update
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
