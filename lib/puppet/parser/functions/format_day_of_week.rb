module Puppet::Parser::Functions
  newfunction(:format_day_of_week, :type => :rvalue,:doc => <<-EOS
Validates and formats a day of week, returning it in the format that the
patchmgmt module expects

  EOS
) do |args|
    # send an error immediately if we got passed nothing
    raise Puppet::ParseError, "no day of week specified! " if args[0] == nil

    # fiddle with input
    dow_in = args[0]
    fmt_in = 'lowercase'
    fmt_in = args[1] unless args[1] == nil
    len_in = 99
    len_in = args[2] unless args[2] == nil

    # allow the user to pass their own translation hash
    fmt_other = { }
    fmt_other = args[3] unless args[3] == nil
    raise Puppet::ParseError, "other format must be a hash of values" \
      if not fmt_other.is_a?(Hash)

    # setup some useful objects
    fmt_options = [ 'lowercase', 'uppercase', 'capitalize', 'other' ]
    len_min = 1
    len_in = 99 if len_in < 1

    # let's normalize our input
    dow_normal = dow_in.downcase.chomp
    case dow_normal
    when /^m(on(day)?)?$/
      dow_normal="monday"
    when /^t(ue(sday)?)?$/
      dow_normal="tuesday"
    when /^w(ed(nesday)?)?$/
      dow_normal="wednesday"
    when /^th(u(rsday)?)?$/
      dow_normal="thursday"
    when /^f(ri(day)?)?$/
      dow_normal="friday"
    when /^s(at(urday)?)?$/
      dow_normal="saturday"
    when /^(sn|su(n(day)?)?)$/
      dow_normal="sunday"
    else
      raise Puppet::ParseError, \
        "unable to determine day of week from '#{dow_in}'"
    end

    # do our translation and return our value (or bomb)
    case fmt_in
    when 'lowercase'
      return dow_normal[0,len_in]
    when 'uppercase'
      return dow_normal.upcase[0,len_in]
    when 'capitalize'
      return dow_normal.capitalize[0,len_in]
    when 'other'
      raise Puppet::ParseError if fmt_other == nil
      raise Puppet::ParseError if fmt_in == nil
      raise Puppet::ParseError if len_in == nil
      #return fmt_other[fmt_in][0,len_in]
      return fmt_other[dow_normal]
    else
      raise Puppet::ParseError, "invalid output format specified!"
    end
  end
end
