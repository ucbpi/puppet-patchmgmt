# Patch Management Module #
[![Build Status](https://travis-ci.org/arusso/puppet-patchmgmt.png?branch=master)](https://travis-ci.org/arusso/puppet-patchmgmt)

This module provides mechanisms to assist with patch management

# Examples #

<pre><code>
  class { 'patchmgmt':
    clean       => true,
    clean_day   => 'sun',
    clean_email => 'clean-patchmgmt@localhost',
    clean_hour  => '10',  # start at 10am
    clean_splay => '120', # 2 hour splay
    list        => true,
    list_day    => 'tues',
    list_email  => 'list-patchmgmt@localhost',
    list_hour   => '14', # start at 2pm
    list_splay  => '120', # 2 hour splay
    patch       => true,
    patch_day   => 'wed',
    patch_hour  => '07',
    patch_splay => '240',
  }
</code></pre>
 
License
-------

None

Contact
-------

Aaron Russo <arusso@berkeley.edu>

Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/arusso/puppet-patchmgmt/issues/)
