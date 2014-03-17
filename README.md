# G5 Stack

G5 Stack is a collection of [Chef](http://docs.opscode.com/chef_solo.html)
cookbooks that are commonly used at G5. It is intended to simplify the process
of setting up a new development environment via [vagrant](http://vagrantup.com).

**G5 Stack is NOT intended for use in production environments.**

## Current Version

0.0.1

## Requirements

* chef-solo >= 10.14
* vagrant >= 1.3

## Installation

Add g5stack to your vagrant project as a git submodule:

```console
$ git submodule add git@github.com:g5search/g5stack.git
$ git commit -m "Install g5stack"
```

Anyone else who clones your repository will have to initialize the
submodule contents:

```console
$ git submodule update --init --recursive
```

## Usage

In order to use the common cookbooks, you must configure the `:chef_solo`
provisioner in vagrant to add g5stack to the cookbooks path. In your
`Vagrantfile`:

```ruby
config.vm.provision :chef_solo do |chef|
  chef.cookbooks_path = [ 'g5stack', 'cookbooks' ]
  # The rest of your provisioner config...
end
```

After that, you can execute any recipe from g5stack in the usual way
(see Examples for details).

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
