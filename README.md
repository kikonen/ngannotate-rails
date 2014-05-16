ngannotate-rails
===========

Use <https://github.com/olov/ng-annotate> in the Rails asset pipeline.

Installation
------------

Add this line to your application's Gemfile:

    gem 'ngannotate-rails', git: 'git@github.com:kikonen/ngannotate-rails.git'

And then execute:

    $ bundle

That's it! ngannotate-rails integrates seamlessly into the Rails asset pipeline; your JavaScript or CoffeeScript assets will automatically be run through the ngannotate pre-minifier.

Versioning
----------

The ngannotate-rails version number mirrors the version number for the version of ngannotate that is bundled with it.

Help
----

  * **Q**: I installed ngannotate-rails, but my assets aren't getting processed with ngannotate.

    **A:** Remember to delete `tmp/cache/assets` or `touch` all the related asset files so that the cached versions get regenerated. If you've precompiled your assets into `public/assets`, you'll need to re-precompile them.

Hacking
-------

### Upgrading ngannotate

The actual ngannotate project is bundled into this gem via [Browserify](https://github.com/substack/node-browserify). You can update to the latest version of ngannotate via Rake:

    rake ngannotate:build

### Test Application

There is a Rails 3 application bundled in `example/` that you can use to test the asset pipeline integration. Don't forget to remove `tmp/cache/assets` after upgrading to the latest version of ngannotate.
