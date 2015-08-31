module Puppet::Parser::Functions
  newfunction(:values_from_hash, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    This function returns an array containing all values specified for the given attribute in the hash(es).

    ENDHEREDOC

    error_head = "values_from_hash(key, [hashes1], [hashes2], ...)"

    # Technically we support two arguments but only first is mandatory ...
    raise(Puppet::ParseError, "#{error_head}: Wrong number of arguments " +
      "given (#{args.size} for >= 2)") if args.size < 2

    result = []
    key = args.shift
    unless key.is_a?(String)
      raise(Puppet::ParseError, "#{error_head}: Requires key as first parameter")
    end
    args.each do |array_of_hashes|
      unless array_of_hashes.is_a?(Array)
        raise(Puppet::ParseError, "#{error_head}: Requires array to work with")
      end

      # Turn everything into string same as join would do ...
      result += [array_of_hashes].flatten.collect do |hash|
        hash[key]
      end
    end
    return result
  end
end

# vim: set ts=2 sw=2 et :
