#
# is_ip_port.rb
#

module Puppet::Parser::Functions
  newfunction(:is_ip_port, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    Returns true if given parameter is a valid IP port.

    ENDHEREDOC

    # load required functions
    Puppet::Parser::Functions.autoloader.load(:is_integer) unless Puppet::Parser::Functions.autoloader.loaded?(:is_integer)

    unless args.length == 1 then
      raise Puppet::ParseError, ("is_ip_port(): wrong number of arguments (#{args.length}; must be 1)")
    end

    if !function_is_integer([args[0]])
      return false
    elsif args[0].to_i < 0 or args[0].to_i > 65535 then
      return false
    end
    return true
  end
end

# vim: set ts=2 sw=2 et :
