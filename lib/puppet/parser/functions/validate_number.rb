module Puppet::Parser::Functions
  newfunction(:validate_number, :doc => <<-'ENDHEREDOC') do |args|
    Validate that all passed values are Numbers. Abort catalog
    compilation if any value fails this check.

    ENDHEREDOC

    unless args.length > 0 then
      raise Puppet::ParseError, ("validate_number(): wrong number of arguments (#{args.length}; must be > 0)")
    end

    # load required functions
    Puppet::Parser::Functions.autoloader.load(:is_numeric) unless Puppet::Parser::Functions.autoloader.loaded?(:is_numeric)

    args.each do |arg|
      unless function_is_numeric([arg])
        raise Puppet::ParseError, ("'#{arg}' is not a valid number.")
      end
    end
  end
end
