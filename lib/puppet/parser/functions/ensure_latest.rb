module Puppet::Parser::Functions
  newfunction(:ensure_latest, :type => :rvalue) do |args|
    value = args[0]
    raise Puppet::ParseError, ("ensure_latest(): wrong type of arguments must be String)") unless value.is_a?(String)
    return "latest" if value == "present"
    return value
  end
end
