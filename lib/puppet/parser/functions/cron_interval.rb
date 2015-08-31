module Puppet::Parser::Functions
  newfunction(:cron_interval, :type => :rvalue, :doc => <<-EOS) do |args|
    Creates a valid cron interval.

    EOS

    error_head = "cron_interval(max_elements, interval, [offset])"

    # Technically we support three arguments but only two are mandatory ...
    raise(Puppet::ParseError, "#{error_head}: Wrong number of arguments given (#{args.size} for >= 2)") if args.size < 2

    # load required functions
    Puppet::Parser::Functions.autoloader.load(:is_integer) unless Puppet::Parser::Functions.autoloader.loaded?(:is_integer)

    # get arguments
    raise(Puppet::ParseError, "#{error_head}: max_elements has to be of type Integer but is '#{args[0]}'") if !function_is_integer([args[0]])
    max_elements = args[0].to_i

    interval = args[1].to_i
    raise(Puppet::ParseError, "#{error_head}: interval has to be greater than 0 but is '#{args[1]}'") if interval <= 0

    start = 0
    if args.size > 2
      start = args[2].to_i
    end

    # create crontab interval
    num_elements = (max_elements/interval).floor
    interval = max_elements/num_elements
    cron_interval = []
    for i in 0..num_elements-1
      cron_interval << (start + i * interval) % max_elements
    end
    cron_interval
  end
end
