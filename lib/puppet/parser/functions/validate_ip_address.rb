module Puppet::Parser::Functions
  newfunction(:validate_ip_address, :doc => <<-'ENDHEREDOC') do |args|
    Validate that all passed values are IP addresses. Abort catalog
    compilation if any value fails this check.

    ENDHEREDOC

    unless args.length > 0 then
      raise Puppet::ParseError, ("validate_ip_address(): wrong number of arguments (#{args.length}; must be > 0)")
    end

    # load required functions
    Puppet::Parser::Functions.autoloader.load(:is_ip_address) unless Puppet::Parser::Functions.autoloader.loaded?(:is_ip_address)

    args.each do |arg|
      unless function_is_ip_address([arg])
        raise Puppet::ParseError, ("'#{arg}' is not a valid IP address.")
      end
    end
  end
end
