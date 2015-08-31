# array_prefix.rb

module Puppet::Parser::Functions
  newfunction(:array_prefix, :type => :rvalue, :doc => <<-EOS
This function prefixes each element of an array with a given string.

*Examples:*

    array_prefix(['a.com','b.com','c.com'], "user@")

Would result in: ["user@a.com","user@b.com","user@c.com"]
    EOS
  ) do |arguments|

    # Technically we support two arguments but only first is mandatory ...
    raise(Puppet::ParseError, "array_prefix(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)") if arguments.size < 2

    array = arguments[0]
    unless array.is_a?(Array)
      raise(Puppet::ParseError, 'array_prefix(): Requires array to work with')
    end

    prefix = arguments[1]
    if prefix
      unless prefix.is_a?(String)
        raise(Puppet::ParseError, 'array_prefix(): Requires string to work with')
      end
    end

    result = [array].flatten.map!{ |elem| "#{prefix}#{elem}" }
    return result
  end
end

# vim: set ts=2 sw=2 et :
