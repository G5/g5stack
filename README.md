# G5 Stack

G5 Stack is a [Chef](http://www.getchef.com) cookbook for
provisioning a new G5 development environment.

**G5 Stack is NOT intended for use in production environments.**

## Current Version

0.2.0

## Requirements

* [ChefDK](http://downloads.getchef.com/chef-dk) >= 0.4.0
* [Vagrant](http://www.vagrantup.com) >= 1.6.5
* [Virtualbox](https://www.virtualbox.org/) >= 4.0
* [Ruby](http://www.ruby-lang.org) >= 1.9

## Installation

### Getting started

1. Copy the example [Berksfile](examples/Berksfile) to your project root.
2. Copy the example [Vagrantfile](examples/Vagrantfile) to your project root.
3. Install required vagrant plugins:

  ```console
  $ vagrant plugin install vagrant-berkshelf vagrant-vbguest
  ```

3. Start up vagrant and log in:

  ```console
  $ vagrant up
  $ vagrant ssh
  ```

4. Inside the VM, you'll find your project mounted at `/my-project`, where
   `my-project` is the basename of the directory where the Vagrantfile resides
   on the host machine. For example, on the host machine:

  ```console
  $ cd ~/projects/my-project
  $ vagrant up
  $ vagrant ssh
  $ cd /my-project
  ```

### Cookbook dependency

If you already have an environment cookbook, you can install g5stack
as a dependency via Berkshelf. There are also a number of G5-specific
wrapper cookbooks that are transitive dependencies of g5stack. You will
have to explicitly load these cookbooks as well.

Add the following lines to your existing `Berksfile`:

```ruby
cookbook 'g5stack', git: 'git@github.com:G5/g5stack.git'
cookbook 'g5-postgresql', git: 'git@github.com:G5/g5-postgresql.git'
cookbook 'g5-rbenv', git: 'git@github.com:G5/g5-rbenv.git'
cookbook 'g5-nodejs', git: 'git@github.com:G5/g5-nodejs.git'
```

## Usage

### Base box

You can save setup time by using a 
[base box](https://docs.vagrantup.com/v2/boxes.html) that has already
been fully provisioned.

If this is a brand-new project, you can generate an initial config file
with the `vagrant init` command:

```console
$ mkdir my-new-project
$ cd my-new-project
$ vagrant init getg5/g5stack
```

Alternatively, you can add the following line to your existing `Vagrantfile`:

```ruby
Vagrant.configure('2') do |config|
  config.vm.box = 'getg5/g5stack'
  # ...
end
```

This base box is a Virtualbox image available via
[Hashicorp Atlas](https://atlas.hashicorp.com/getg5/boxes/g5stack)
(previously known as Vagrantcloud). There is no need to explicitly set
the `box_url`.

### Git config

To use your local git credentials inside the vagrant environment,
add the `g5stack::gitconfig` recipe to the run list in your `Vagrantfile`:

```ruby
config.berkshelf.enabled = true
config.vm.provision :chef_solo do |chef|
  chef.add_recipe('g5stack::gitconfig')
  chef.json = {
    git: {
      user: {
        name: `git config user.name`.strip,
        email: `git config user.email`.strip
      }
    }
  }
end
```

### Provisioning from scratch

If you would like to provision your own box instead of using the base box
image from Vagrantcloud, simply add the default recipe to a
[run-list](http://docs.opscode.com/essentials_node_object_run_lists.html)
in your `Vagrantfile`:

```ruby
config.berkshelf.enabled = true
config.vm.provision :chef_solo do |chef|
  chef.add_recipe('g5stack')
  chef.add_recipe('g5stack::gitconfig')
  chef.json = {
    postgresql: {
      password: {postgres: 'password'}
    },
    git: {
      user: {
        name: `git config user.name`.strip,
        email: `git config user.email`.strip
      }
    }
  }
end
```

Note that you must set the value of the `postgresql['password']['postgres']`
attribute in `chef.json`. For more information, see the
[g5-postgresql](https://github.com/G5/g5-postgresql#attributes) cookbook.

### Environment cookbook

If you need to override or otherwise customize any part of the provisioning
process, you'll probably want to create an 
[environment cookbook](http://blog.vialstudios.com/the-environment-cookbook-pattern)
that depends on g5stack.

Add the following line to your cookbook's `metadata.rb`:

```ruby
depends 'g5stack'
```

And then somewhere in your cookbook's recipe files:

```ruby
include_recipe 'g5stack'
include_recipe 'g5stack::gitconfig'
```

Make sure you've followed the [instructions](#cookbook-dependency)
for installing g5stack and g5 wrapper cookbooks from github via berkshelf.

## Authors

* Maeve Revels / [@maeve](https://github.com/maeve)
* Don Petersen / [@dpetersen](https://github.com/dpetersen)

## Contributions

1. Fork it
2. Set up your [development environment](#development-setup)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Add or update cookbooks as needed.
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new pull request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/G5/g5stack/issues).

### Development Setup ###

1. Clone the repository locally:

  ```console
  $ git clone git@github.com:G5/g5stack.git
  $ cd g5stack
  ```

2. Install required cookbooks using [Berkshelf](http://berkshelf.com/):

  ```console
  $ chef exec berks install
  ```

3. Provision an instance for development using [test-kitchen](http://kitchen.ci):

  ```console
  $ chef exec kitchen converge
  ```

  See `chef exec kitchen help` for more test-kitchen commands.

### Specs ###

The unit tests use [ChefSpec](http://sethvargo.github.io/chefspec/),
and live in the `test/unit` directory. To execute the entire
suite:

```console
$ chef exec rspec
```

To run the [foodcritic](http://acrmp.github.io/foodcritic) linting tool:

```console
$ chef exec foodcritic .
```

The integration tests use [ServerSpec](http://serverspec.org), and live
in the `test/integration/default/serverspec` directory. To execute
the test suite:

```console
$ chef exec kitchen verify
```

### Releasing ###

1. Update the version in the [README](#current-version) and
   [CHANGELOG](./CHANGELOG.md), and [metadata.rb](./metadata.rb), following
   the guidelines of [semantic versioning](http://semver.org).

2. Tag the code with the latest version:

   ```console
   $ git commit -am "Prepare to release v0.1.0"
   $ git tag -a v0.1.0 -m "Extracted nodejs to wrapper cookbook"
   $ git push --tags origin master
   ```

3. Build a clean image using test-kitchen:

   ```console
   $ chef exec kitchen destroy
   $ chef exec kitchen converge
   ```

4. Zero out the VM drive (this will make the final package much smaller):

   ```console
   $ chef exec kitchen login
   $ sudo dd if=/dev/zero of=/EMPTY bs=1M
   $ sudo rm -f /EMPTY
   ```

   You can safely ignore the error message "No space left on this device."

4. Find the name of the VirtualBox instance you want to package
   (e.g. "g5stack-ubuntu-1204_default_1425092220656_52831"):

  ```console
  $ VBoxManage list vms
  "reputation_default_1391587101" {cfaed7c5-ab73-4306-a776-06fbdad77c8e}
  "g5-orion-vagrant_default_1398901466904_16526" {815ff90c-966d-473f-a75c-d8c3d5eb26b4}
  "g5-authentication-vagrant_default_1406238023773_17139" {76beb2f0-117f-4953-b348-db3eb92020d8}
  "packer-ubuntu-12.04-amd64_1406347781876_30580" {d92aac7b-37be-4a28-91a5-0782d5bef584}
  "g5stack-ubuntu-1204_default_1425092220656_52831" {438a50e6-ce60-4417-b7d2-3b671083470c}
  ```

5. Use vagrant to package the base box:

  ```console
  $ cd .kitchen/kitchen-vagrant/g5stack-ubuntu-1204
  $ vagrant package --output ../../../package.box --base g5stack-ubuntu-1204_default_1425092220656_52831
  $ cd ../../..
  ```

6. Upload package.box to [Amazon S3](https://console.aws.amazon.com/s3/home?region=us-west-2).
   All of G5's base boxes live in the `g5-vagrant-boxes` bucket, with the
   folder structure `<box_name>/<version>` (e.g. `g5stack/0.2.0`). When
   uploading the file, make sure to set the file permissions to "make everything
   public" in order to enable anonymous read-only access.

7. Register a new version of the g5stack box in
   [Hashicorp Atlas](https://atlas.hashicorp.com/getg5/boxes/g5stack)
   (previously known as Vagrantcloud). Click "Create new version" and enter the
   tag. Click "Create new provider" and enter "virtualbox" as the provider type
   and the S3 URL to the file. To publicly release the box, click "Edit" next
   to the version identifier and then click "Release version".

## License

Copyright (c) 2014 G5

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
