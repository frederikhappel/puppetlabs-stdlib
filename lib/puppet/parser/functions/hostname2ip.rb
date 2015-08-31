module Puppet::Parser::Functions
  newfunction(:hostname2ip, :type => :rvalue) do |args|
    hostname = args[0]
    raise Puppet::ParseError, ("hostname2ip(hostname): hostname must be String. Looks like #{hostname.inspect}") unless hostname.is_a?(String)

    # load required functions
    Puppet::Parser::Functions.autoloader.load(:is_ip_address) unless Puppet::Parser::Functions.autoloader.loaded?(:is_ip_address)

    if function_is_ip_address([hostname])
      ipaddress = hostname
    else
      ipaddress = IPSocket::getaddress(hostname)
    end

    return ipaddress
  end
end
