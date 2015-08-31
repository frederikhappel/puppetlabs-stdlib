module Puppet::Parser::Functions
  newfunction(:validate_puppet_source, :doc => <<-'ENDHEREDOC') do |args|
    Validate that all passed values are puppet sources. Abort catalog
    compilation if any value fails this check.

    ENDHEREDOC

    unless args.length > 0 then
      raise Puppet::ParseError, ("validate_puppet_source(): wrong number of arguments (#{args.length}; must be > 0)")
    end

    # load required functions
    Puppet::Parser::Functions.autoloader.load(:is_puppet_source) unless Puppet::Parser::Functions.autoloader.loaded?(:is_puppet_source)

    args.each do |arg|
      unless function_is_puppet_source([arg])
        raise Puppet::ParseError, ("'#{arg}' is not a valid puppet source.")
      end
    end
  end
end
