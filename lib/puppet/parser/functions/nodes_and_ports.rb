module Puppet::Parser::Functions
  newfunction(:nodes_and_ports, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    This function returns a hash with nodes => array of nodes and port => unique array with their ports.

    Example:
      $nodes = [
        'node1.example.org[9300-9400]',
        'node2.example.org',
        'node3.example.org[19300:19400]',
      ],

      nodes_and_ports($nodes, 9300) =>
      {
        nodes => ['node1.example.org', 'node2.example.org', 'node3.example.org'],
        ports => ['9300:9400', 9300, '19300:19400'],
      }
    ENDHEREDOC

    error_head = "nodes_and_ports([nodes], default_port)"

    raise(Puppet::ParseError, "#{error_head}: Wrong number of arguments " +
      "given (#{args.size} for 1)") if args.size < 2

    # load required functions
    Puppet::Parser::Functions.autoloader.load(:is_ip_port) unless Puppet::Parser::Functions.autoloader.loaded?(:is_ip_port)

    # check parameters
    nodes = args[0]
    default_port = args[1]
    if !nodes.is_a?(Array)
      raise(Puppet::ParseError, "#{error_head}: Requires array to work with")
    elsif !function_is_ip_port([default_port])
      raise Puppet::ParseError, ("#{error_head}: #{default_port.inspect} is not a valid IP port.")
    end

    # process given nodes
    nodes_and_ports = {
      'complete' => [],
      'nodes' => [],
      'ports'=> [],
    }
    nodes.each do |node|
      nodes_and_ports['complete'] << node
      node_parts = node.split('[', 2)
      if node_parts[1].nil?
        node_parts = node.split(':', 2)
        if node_parts[1].nil?
          nodes_and_ports['complete'][-1] += ":#{default_port}"
          nodes_and_ports['ports'] << default_port
        else
          nodes_and_ports['ports'] << node_parts[1]
        end
      else
        nodes_and_ports['ports'] << node_parts[1].gsub(']','').gsub('-',':')
      end
      nodes_and_ports['nodes'] << node_parts[0]
    end

    # remove duplicates and set default values
    nodes_and_ports['nodes'].uniq!
    nodes_and_ports['ports'].uniq!

    return nodes_and_ports
  end
end
