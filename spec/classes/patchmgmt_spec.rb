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
  context "=> sun / mon / tue" do
    let(:params) {
      {
        'clean'       => true,
        'clean_day'   => 'sun',
        'clean_email' => 'clean-patchmgmt@localhost',
        'clean_hour'  => '10',  # start at 10am
        'clean_splay' => '120', # 2 hour splay
        'list_day'    => 'tues',
        'list_email'  => 'list-patchmgmt@localhost',
        'list_hour'   => '14', # start at 2pm
        'list_splay'  => '120', # 2 hour splay
        'patch'       => true,
        'patch_day'   => 'wed',
        'patch_hour'  => '07',
        'patch_splay' => '240',
      } }
      it do
        should contain_file('/usr/local/sbin/cleanupdates')
        should contain_file('/usr/local/sbin/listupdates')
        should contain_file('/usr/local/sbin/runupdates')
        should contain_file('/etc/patchmgmt.conf')
      end
  end
end
