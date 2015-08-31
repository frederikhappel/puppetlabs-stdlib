module Puppet::Parser::Functions
  newfunction(:validate_float, :doc => <<-'ENDHEREDOC') do |args|
    Validate that all passed values are float data structures. Abort catalog
    compilation if any value fails this check.

    ENDHEREDOC

    unless args.length > 0 then
      raise Puppet::ParseError, ("validate_float(): wrong number of arguments (#{args.length}; must be > 0)")
    end

    # load required functions
    Puppet::Parser::Functions.autoloader.load(:is_float) unless Puppet::Parser::Functions.autoloader.loaded?(:is_float)

    args.each do |arg|
      unless function_is_float([arg])
        raise Puppet::ParseError, ("'#{arg}' is not a valid float.")
      end
    end
  end
end
