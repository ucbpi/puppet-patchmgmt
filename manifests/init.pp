# == Class: patchmgmt
#
# Simple patch management class based on a weekly patching schedule
#
# === Parameters
#
# [*clean*]
#   Should we clean our package cache?  This consists of dumping the cache, and
#   re-downloading the cache.
#
# [*clean_day*]
#   What day should we clean the cache? (mon/tue/wed/thu/fri/sat/sun)
#
# [*clean_email*]
#   Where should we email the results of this process?  If not specified, will
#   default to 'root@localhost'
#
# [*clean_splay*]
#   Cleaning of cache will be delayed by up to $clean_splay to combat against
#   thundering herds
#
# [*list*]
#   Should we list updates to be installed? Useful for emailing the day before
#   patching, in case one needs to take a quick looksie.
#
# [*list_day*]
#   What day should we list the updates? (mon/tue/wed/thu/fri/sat/sun)
#
# [*list_email*]
#   Where should we email the results of this process? Default is root@localhost
#
# [*list_splay*]
#   Listing of updates will be delayed by up to $list_splay to combat against
#   thundering herds
#
# [*patch*]
#   Should we actually patch?
#
# [*patch_day*]
#   When should we patch? (mon/tue/wed/thu/fri/sat/sun)
#
# [*patch_splay*]
#   Patching is delayed by up to $patch_splay to combat against thundering herds
#
# === Additional Software Requirements
#
# The following binaries are required, and not installed automatically:
#  /bin/mail
#
# In addition, the following packages are required:
#  yum-plugin-downloadonly, a cron package (cronie, vixie-cron, etc)
#
# === Authors
#
# Aaron Russo <arusso@berkeley.edu>
#
class patchmgmt (
  $clean = true,
  $clean_day = undef,
  $clean_email = undef,
  $clean_hour = undef,
  $clean_splay = 120,
  $list = true,
  $list_day = undef,
  $list_email = undef,
  $list_hour = undef,
  $list_splay = 120,
  $patch = true,
  $patch_day = undef,
  $patch_email = undef,
  $patch_hour = undef,
  $patch_splay = 120
) {
  ##############################################################################
  # LOGIC KUNG FOO
  #
  $clean_r = any2bool( $clean )
  $list_r = any2bool( $list )
  $patch_r = any2bool( $patch )

  case downcase( $clean_day ) {
    /^(mon|tue|wed|thu|fri|sat|sun)$/: { $clean_day_r = downcase( $clean_day ) }
    default: { fail( "Class[${name}] : invalid clean day passed" ) }
  }
  case downcase( $list_day ) {
    /^(mon|tue|wed|thu|fri|sat|sun)$/: { $list_day_r = downcase( $list_day ) }
    default: { fail( "Class[${name}] : invalid list day passed" ) }
  }
  case downcase( $patch_day ) {
    /^(mon|tue|wed|thu|fri|sat|sun)$/: { $patch_day_r = downcase( $patch_day ) }
    default: { fail( "Class[${name}] : invaild patch day passed" ) }
  }

  validate_re( $clean_splay, '^[0-9]+$' )
  $clean_splay_r = $clean_splay

  validate_re( $list_splay, '^[0-9]+$' )
  $list_splay_r = $list_splay

  validate_re( $patch_splay, '^[0-9]+$' )
  $patch_splay_r = $patch_splay

  validate_re( $clean_hour, '^([0-1]?[0-9]|2[0-3])$' )
  $clean_hour_r = $clean_hour

  validate_re( $list_hour, '^([0-1]?[0-9]|2[0-3])$' )
  $list_hour_r = $list_hour

  validate_re( $patch_hour, '^([0-1]?[0-9]|2[0-3])$' )
  $patch_hour_r = $patch_hour

  case $clean_email {
    undef: { $clean_email_r = 'root@localhost' }
    default: { $clean_email_r = $clean_email }
  }
  case $list_email {
    undef: { $list_email_r = 'root@localhost' }
    default: { $list_email_r = $list_email }
  }
  case $patch_email {
    undef: { $patch_email_r = 'root@localhost' }
    default: { $patch_email_r = $patch_email }
  }

  ##############################################################################
  # RESOURCES
  #
  file { '/usr/local/sbin/cleanupdates':
    ensure  => present,
    mode    => '0550',
    owner   => 'root',
    group   => 'root',
    content => template('patchmgmt/cleanupdates.erb'),
  }

  file { '/usr/local/sbin/runupdates':
    ensure  => present,
    mode    => '0550',
    owner   => 'root',
    group   => 'root',
    content => template('patchmgmt/runupdates.erb'),
  }

  file { '/usr/local/sbin/listupdates':
    ensure  => present,
    mode    => '0550',
    owner   => 'root',
    group   => 'root',
    content => template('patchmgmt/runupdates.erb'),
  }

  file { '/etc/patchmgmt.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    content => template('patchmgmt/patchmgmt.conf.erb'),
  }

  file { '/etc/cron.d/patchmgmt':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    content => template('patchmgmt/patchmgmt.cron.erb'),
  }

  file { '/usr/local/sbin/print_enabled_repos':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0550',
    source => 'puppet:///modules/patchmgmt/print_enabled_repos',
  }
}
