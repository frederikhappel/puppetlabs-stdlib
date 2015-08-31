module Puppet::Parser::Functions
  newfunction(:is_puppet_source, :type => :rvalue) do |args|
    raise Puppet::ParseError, ("is_puppet_source(): wrong number of arguments (#{args.length}; must be 1)") if args.length < 1
    source = args[0]
    if source.is_a?(String) then
      return source.index("puppet:///") == 0
    end
    return false
  end
end
