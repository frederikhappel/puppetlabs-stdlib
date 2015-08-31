module Puppet::Parser::Functions
  newfunction(:validate_ip_port, :doc => <<-'ENDHEREDOC') do |args|
    Validate that all passed values are valid ip ports. Abort catalog
    compilation if any value fails this check.

    ENDHEREDOC

    unless args.length > 0 then
      raise Puppet::ParseError, ("validate_ip_port(): wrong number of arguments (#{args.length}; must be > 0)")
    end

    # load required functions
    Puppet::Parser::Functions.autoloader.load(:is_ip_port) unless Puppet::Parser::Functions.autoloader.loaded?(:is_ip_port)

    args.each do |arg|
      unless function_is_ip_port([arg])
        raise Puppet::ParseError, ("'#{arg}' is not a valid IP port.")
      end
    end
  end
end
