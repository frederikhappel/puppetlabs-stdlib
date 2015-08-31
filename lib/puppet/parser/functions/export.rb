# function to export a given resource
module Puppet::Parser::Functions
  newfunction(:export, :doc => <<-'ENDHEREDOC') do |args|
    Exports resource from the context it was called.

    ENDHEREDOC

    resource.exported = true
  end
end
