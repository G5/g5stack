## v0.2.1 (2015-03-03)

* Move base box image to getg5/g5stack instead of maeve/g5stack
* Use sudo cookbook to make vagrant user a password-less sudoer
* Disable SSH keypair regeneration/insertion while managing base box
* Rename test-kitchen instance to "g5stack" instead of "default"
* More detailed documentation around the release process

## v0.2.0 (2015-02-26)

* Use ChefDK consistently for cookbook development
* Upgrade g5-rbenv to pick up changes for ruby 2.2.0
* Add imagemagick to the base box
* Upgrade g5-postgresql to pick up changes for postgresql-contrib

## v0.1.2 (2014-9-14)

* Upgrade g5-nodejs cookbook to pick up changes for grunt-cli

## v0.1.1 (2014-8-30)

* Upgrade g5-nodejs cookbook to pick up changes to npm prefix

## v0.1.0 (2014-8-18)

* Use bundler for gem dependency management
* Replace git submodules with berkshelf for cookbook dependency management
* Use chefspec for unit testing
* Use test-kitchen and serverspec for integration tests
* Extract custom wrapper cookbooks to separate repos
* Install nodejs via cookbook instead of directly using apt
* Install ember-cli and bower
* Release base box images to Vagrantcloud

## v0.0.1 (2014-3-3)

* Initial releasegv
