# G5 Stack

G5 Stack is a [Chef](http://docs.opscode.com/chef_solo.html) cookbook for
provisioning a new G5 development environment. It is intended to
be used with [vagrant](http://vagrantup.com).

**G5 Stack is NOT intended for use in production environments.**

## Current Version

0.0.1

## Requirements

* [Chef](http://www.getchef.com) >= 10
* [Vagrant](http://www.vagrantup.com) >= 1.5
* [Ruby](http://www.ruby-lang.org) >= 1.9
* [Virtualbox](https://www.virtualbox.org/) >= 4.0 (if using the base box image)

## Installation

The g5stack cookbook is currently only available via github. You can use
one of Chef's dependency managers (e.g. berkshelf, librarian-chef).
Alternatively, you can install the cookbook using git submodules.

### Berkshelf

We recommend using [Berkshelf](http://berkshelf.com) to manage the
installation.

To initialize Berkshelf in your project, if you haven't done so
already:

```console
$ cd my-chef-cookbook
$ gem install berkshelf
$ berks init
```

To reference the cookbook in github, simply add the following line to your
`Berksfile`:

```ruby
cookbook 'g5stack', git: 'git@github.com:G5/g5stack.git'
```

### Git submodule

If you do not want to use a dependency management tool to install your
cookbooks, you can still use g5stack as a
[git submodule](http://git-scm.com/docs/git-submodule). In your project:

```console
$ git submodule add git@github.com:g5/g5stack.git cookbooks/g5stack
$ git commit -m "Install g5stack"
```

Anyone else who clones your repository will have to initialize the
submodule contents:

```console
$ git submodule update --init --recursive
```

## Usage

### Base box

The quickest and simplest way to use this cookbook is to configure Vagrant
to use a [base box](https://docs.vagrantup.com/v2/boxes.html) that has already
been fully provisioned.

If this is a brand-new project, you can generate an initial Vagrantfile
with the `vagrant init` command:

```console
$ mkdir my-new-project
$ cd my-new-project
$ vagrant init maeve/g5stack
```

Alternatively, you can add the following line to your `Vagrantfile`:

```ruby
Vagrant.configure('2') do |config|
  config.vm.box = 'maeve/g5stack'
  # ...
end
```

This base box is Virtualbox image hosted on
[Vagrantcloud](https://vagrantcloud.com). There is no need to explicitly set
the `box_url` as long as your version of Vagrant is at least 1.5.

If you use the base box, you should also install the
[vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin to keep
the version of the
[Virtualbox Guest Additions](https://www.virtualbox.org/manual/ch04.html)
installed on the base box in sync with the local version of Virtualbox:

```console
$ vagrant plugin install vagrant-vbguest
```

### Run list

If you would like to provision your own box instead of using the base box
image from Vagrantcloud, simply add the default recipe to a
[run-list](http://docs.opscode.com/essentials_node_object_run_lists.html)
in your `Vagrantfile`:

```ruby
config.vm.provision :chef_solo do |chef|
  chef.cookbooks_path = [ 'cookbooks' ]
  chef.add_recipe('g5stack')
  chef.json = {
    postgresql: {
        password: {postgres: 'password'}
    }
  }
end
```

Note that you must set the value of the `postgresql['password']['postgres']`
attribute in `chef.json`. For more information, see the
[g5-postgresql](https://github.com/g5/g5-postgresql#attributes) cookbook.

### Cookbook dependency

If you need to override or otherwise customize any part of the provisioning
process, you'll probably want to create a separate cookbook defining the setup
for your specific environment. In this case, you'll want to add g5stack as a
dependency of your custom cookbook.

Add the following line to your cookbook's `metadata.rb`:

```ruby
depends 'g5stack'
```

And then somewhere in your cookbook's recipe files:

```ruby
include_recipe 'g5stack'
```

## Examples

### Using multiple cookbooks in a run-list

If you want to run additional cookbooks, but do not require any custom
logic or configuration, you can just add everything you need to the
run-list in your `Vagrantfile`. Any calls to `add_recipe` on the provisioner
instance will add that recipe to the end of the run-list. For example:

```ruby
config.vm.provision :chef_solo do |chef|
  chef.cookbooks_path = [ 'cookbooks' ]
  chef.add_recipe('g5stack')
  chef.add_recipe('another-cookbook::special_recipe')
end
```

### Defining an environment cookbook

If you need a greater degree of customization than a run-list can provide,
you may want to create an
[environment cookbook](http://blog.vialstudios.com/the-environment-cookbook-pattern),
with a default recipe that loads every other recipe that you need.

For example, your `Vagrantfile` would contain:

```ruby
config.vm.provision :chef_solo do |chef|
  chef.cookbooks_path = [ 'cookbooks' ]
  chef.add_recipe('my-environment-cookbook')
  # ...
end
```

Declare a dependency on g5stack in `metadata.rb`:

```ruby
depends 'g5stack'
```

Define new attributes in `attributes/default.rb`:

```ruby
default['rbenv']['rake']['version'] = '10.3.2'
```

Execute particular recipes and any custom logic in `recipes/default.rb`:

```ruby
include_recipe 'g5stack'

rbenv_gem 'rake' do
  version node['rbenv']['rake']['version']
  ruby_version node['rbenv']['ruby_version']
end

# And so on...
```

For more information about how to write cookbooks, see the
[chef documentation](http://docs.opscode.com/essentials_cookbooks.html).

## Authors

* Maeve Revels / [@maeve](https://github.com/maeve)
* Don Petersen / [@dpetersen](https://github.com/dpetersen)

## Contributions

1. Fork it
2. Get it running (see Installation above)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Add or update cookbooks as needed.
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new pull request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/g5/g5stack/issues).

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
