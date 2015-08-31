module Puppet::Parser::Functions
  newfunction(:getvalue, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    Lookup a variable in a remote namespace. Return default value if given and
    variable has not been defined. Return :undef if variable is empty.

    For example:

        $foo = getvalue('site::data::foo')
        # Equivalent to $foo = $site::data::foo

    This is useful if the namespace itself is stored in a string:

        $datalocation = 'site::data'
        $bar = getvalue("${datalocation}::bar")
        # Equivalent to $bar = $site::data::bar
    ENDHEREDOC

    unless args.length > 0 and args.length <= 2
      raise Puppet::ParseError, ("getvalue(): wrong number of arguments (#{args.length}; must be at least 1)")
    end

    varname = args[0]
    value = self.lookupvar(varname)
    debug "getvalue(): #{varname} == #{value}:#{value.class}, default == #{args[1]}"
    if args.length > 1 and value.nil?
      value = args[1]
    end

    if value.nil? or ([Array, Hash, String].include?(value.class) and value.empty?)
      debug "getvalue('#{varname}',...) returning :undef"
      return :undef
    else
      debug "getvalue('#{varname}',...) returning #{value}"
      return value
    end
  end
end
