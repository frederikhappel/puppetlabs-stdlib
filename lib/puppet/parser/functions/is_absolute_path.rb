#
# is_absolute_path.rb
#

module Puppet::Parser::Functions
  newfunction(:is_absolute_path, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    Returns true if the variable passed to this function is an absolute path.

    ENDHEREDOC

    require 'puppet/util'

    if (args.size != 1) then
      raise(Puppet::ParseError, "is_absolute_path(): Wrong number of arguments "+
        "given #{args.size} for 1")
    end

    arg = args[0]

    if Puppet::Util.respond_to?(:absolute_path?) then
      if Puppet::Util.absolute_path?(arg, :posix) or Puppet::Util.absolute_path?(arg, :windows) then
        return true
      else
        return false
      end
    else
      # This code back-ported from 2.7.x's lib/puppet/util.rb Puppet::Util.absolute_path?
      # Determine in a platform-specific way whether a path is absolute. This
      # defaults to the local platform if none is specified.
      # Escape once for the string literal, and once for the regex.
      slash = '[\\\\/]'
      name = '[^\\\\/]+'
      regexes = {
        :windows => %r!^(([A-Z]:#{slash})|(#{slash}#{slash}#{name}#{slash}#{name})|(#{slash}#{slash}\?#{slash}#{name}))!i,
        :posix   => %r!^/!,
      }

      if (!!(arg =~ regexes[:posix])) || (!!(arg =~ regexes[:windows])) then
        return true
      else
        return false
      end
    end
  end
end

# vim: set ts=2 sw=2 et :
