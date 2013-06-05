require 'spec_helper'

describe 'patchmgmt' do
  context "=> no params" do
    it do
      expect {
        should contain_file('/usr/local/sbin/cleanupdates')
        should contain_file('/usr/local/sbin/listupdates')
        should contain_file('/usr/local/sbin/runupdates')
        should contain_file('/etc/patchmgmt.conf')
        should contain_file('/etc/cron.d/patchmgmt')
        should contain_file('/usr/local/sbin/print_enabled_repos')
      }.to raise_error(Puppet::Error)
    end
  end
end
