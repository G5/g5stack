guard 'foodcritic', cookbook_paths: '.' do
  watch(%r{attributes/.+\.rb$})
  watch(%r{providers/.+\.rb$})
  watch(%r{recipes/.+\.rb$})
  watch(%r{resources/.+\.rb$})
  watch(%r{^templates/(.+)})
  watch('metadata.rb')
end

guard :rspec, cmd: 'bundle exec rspec', spec_paths: ['test/unit'] do
  watch(%r{^test/unit/.+_spec\.rb$})
  watch(%r{^(recipes)/(.+)\.rb$})      { |m| "test/unit/#{m[1]}/#{m[2]}_spec.rb" }
  watch('test/unit/spec_helper.rb')    { 'test/unit' }
  watch(%r{^libraries/.+\.rb$})        { 'test/unit' }
end

guard 'kitchen' do
  watch(%r{test/integration/.+})
  watch(%r{^recipes/(.+)\.rb$})
  watch(%r{^attributes/(.+)\.rb$})
  watch(%r{^files/(.+)})
  watch(%r{^templates/(.+)})
  watch(%r{^providers/(.+)\.rb})
  watch(%r{^resources/(.+)\.rb})
end
