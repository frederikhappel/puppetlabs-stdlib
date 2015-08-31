#
#  sha256.rb
#
module Puppet::Parser::Functions
  newfunction(:sha256, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |arguments|
    This function returns the sha256 sum for a given tring.

    *Examples:*
        sha256("aaa", "KHC6MZR36kSFLaFGJAdwFxGi7uapm")

    Would result in: "4b4843364d5a5233366b53464c6146474a41647746784769377561706d456d521036c33160066a954ab32c141d2518aed8b4daa3951f29b71e8ca9f3cb"
    ENDHEREDOC

    require 'digest/sha2'

    raise(Puppet::ParseError, "sha256(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    raise(Puppet::ParseError, "sha256(): Wrong number of arguments " +
      "given (#{arguments.size} for 1 or 2)") if arguments.size > 2

    password = arguments[0]
    salt = arguments[1] || nil

    unless password.is_a?(String)
      raise(Puppet::ParseError, 'sha256(): Requires a ' +
        "String argument, you passed: #{password.class}")
    end

    if salt.nil?
      saltedpass = Digest::SHA256.digest(password)
      return (saltedpass).unpack('H*')[0]
    else
      saltedpass = Digest::SHA256.digest(salt + password)
      return (salt + saltedpass).unpack('H*')[0]
    end
  end
end

# vim: set ts=2 sw=2 et :
