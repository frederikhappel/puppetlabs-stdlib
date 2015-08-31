#
# is_array.rb
#

module Puppet::Parser::Functions
  newfunction(:split, :type => :rvalue, :doc => <<-EOS
Returns an array from string.split(args).
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "split(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)") if arguments.size < 2

    string = arguments[0]
    separator = arguments[1]

    raise(Puppet::ParseError, "split(): Wrong type of arguments " +
      "argument 0 is not a string)") unless string.is_a?(String)

    raise(Puppet::ParseError, "split(): Wrong type of arguments " +
      "argument 1 is not a string)") unless separator.is_a?(String)

    result = string.split(separator)

    return result
  end
end

# vim: set ts=2 sw=2 et :
