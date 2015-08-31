module Puppet::Parser::Functions
  newfunction(:is_puppet_resource, :type => :rvalue) do |args|
    raise Puppet::ParseError, ("is_puppet_resource(): wrong number of arguments (#{args.length}; must be 1)") if args.length < 1
    return args[0].is_a?(Puppet::Resource)
  end
end
