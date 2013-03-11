# A sample Guardfile
# More info at https://github.com/guard/guard#readme
#notification :gntp
guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
  watch('spec/spec_helper_api.rb')  { "spec" }
  #watch(%r{^spec/support/(.+)\.rb$})  { "spec" }
  #watch(%r{^spec/fixtures/(.+)$})  { "spec" }
end

