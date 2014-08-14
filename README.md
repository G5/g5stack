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
$ git submodule add git@github.com:g5search/g5stack.git cookbooks/g5stack
$ git commit -m "Install g5stack"
```

Anyone else who clones your repository will have to initialize the
submodule contents:

```console
$ git submodule update --init --recursive
```

## Usage

### Base box

TODO

### Run list

TODO

### Cookbook dependency

TODO

## Examples

### Using cookbooks in a run-list

The simplest way to execute recipes from chef cookbooks is to use a
[run-list](http://docs.opscode.com/essentials_node_object_run_lists.html)
in your `Vagrantfile`. Any calls to `add_recipe` on the provisioner instance
will add that recipe to the end of the run-list:

```ruby
config.vm.provision :chef_solo do |chef|
  chef.cookbooks_path = [ 'g5stack', 'cookbooks' ]
  chef.add_recipe('sane_postgresql')
  chef.add_recipe('vagrant_rbenv')
end
```

### Defining a main cookbook

If you need a greater degree of customization than a run-list can provide,
you may want to define a main cookbook for your environment, with a default
recipe that loads every other recipe that you need.

Your `Vagrantfile` would contain:

```ruby
config.vm.provision :chef_solo do |chef|
  chef.cookbooks_path = [ 'g5stack', 'cookbooks' ]
  chef.add_recipe('main')
  # ...
end
```

Direct dependencies on g5stack cookbooks are declaried in
`cookbooks/main/metadata.rb`:

```ruby
depends 'vagrant_rbenv'
depends 'phantomjs'
```

Configure attributes in `cookbooks/main/attributes/default.rb`:

```ruby
default[:rbenv][:global_ruby_version] = '2.1.0'
```

Then you can execute particular recipes and any related logic in
`cookbooks/main/recipes/default.rb`:

```ruby
include_recipe 'vagrant_rbenv'

rbenv_ruby node[:rbenv][:global_ruby_version] do
  global true
end

rbenv_gem 'bundler' do
  ruby_version node[:rbenv][:global_ruby_version]
end

include_recipe 'phantomjs'
```

For more information about how to write cookbooks, see the
[chef documentation](http://docs.opscode.com/essentials_cookbooks.html).

## Authors

* Don Petersen / [@dpetersen](https://github.com/dpetersen)
* Maeve Revels / [@maeve](https://github.com/maeve)

## Contributions

1. Fork it
2. Get it running (see Installation above)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Add or update cookbooks as needed.
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new pull request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/g5search/g5stack/issues).

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
