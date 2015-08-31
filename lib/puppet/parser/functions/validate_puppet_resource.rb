module Puppet::Parser::Functions
  newfunction(:validate_puppet_resource, :doc => <<-'ENDHEREDOC') do |args|
    Validate that all passed values are puppet resources. Abort catalog
    compilation if any value fails this check.

    ENDHEREDOC

    unless args.length > 0 then
      raise Puppet::ParseError, ("validate_puppet_resource(): wrong number of arguments (#{args.length}; must be > 0)")
    end

    # load required functions
    Puppet::Parser::Functions.autoloader.load(:is_puppet_resource) unless Puppet::Parser::Functions.autoloader.loaded?(:is_puppet_resource)

    args.each do |arg|
      unless function_is_puppet_resource([arg])
        raise Puppet::ParseError, ("'#{arg}' is not a valid puppet resource.")
      end
    end
  end
end
