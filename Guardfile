notification :gntp

guard :rspec, cmd:'rspec' do

    watch ( %r{^lib/(.+)\.rb$} )       { |m| "spec/#{m[1]}_spec.rb" }
    watch ( %r{^spec/(.+)_spec\.rb$} ) { |m| "spec/#{m[1]}_spec.rb" }
    watch ( 'spec/spec_helper.rb')     { "spec" }

end