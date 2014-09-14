#Guard runs continuous tests, triggered when you save a file.
#simply run `guard` to have your tests run continuously so you don't have
#to alt-tab and run tests all the time.

guard 'rake', :task => 'all' do
  watch(%r{^spec\/(?!fixtures|acceptance)\/*(.+)_spec.rb})
  # watch(%r{^manifests/(.+)\.pp$}) 
  watch(%r{^manifests\/(.+).pp$}) { |m| "spec/classes/#{m[1]}_spec.rb" }
  watch(%r{^manifests\/(.+).pp$}) { |m| "spec/defines/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "all" }
end
