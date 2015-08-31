module Puppet::Parser::Functions
  newfunction(:truncate, :type => :rvalue) do |args|
    raise Puppet::ParseError, ("getResourceTitle(): wrong number of arguments (#{args.length}; must be 2)") if args.length < 2
    obj = args[0]
    pos = args[1].to_i
    if obj.is_a?(String) then
      return obj[0,pos]
    else
      raise Puppet::ParseError, ("getResourceTitle(): wrong type of argument")
    end
    return nil
  end
end 