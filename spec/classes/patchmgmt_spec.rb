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

  context "=> mon clean, tues list, weds patch" do
    let(:params) {
      { 'patch_day' => 'wed',
        'patch_hour' => '10',
        'list_day' => 'tue',
        'list_hour' => '10',
        'clean_day' => 'mon',
        'clean_hour' => '10' } }
    it do
      should contain_file('/usr/local/sbin/cleanupdates') \
        .with_content(/TARGET='root@localhost'/) \
        .with_content(/DELAY="-R 120"/) 

      should contain_file('/usr/local/sbin/listupdates') \
        .with_content(/TARGET='root@localhost'/) \
        .with_content(/DELAY="-R 120"/)

      should contain_file('/usr/local/sbin/runupdates') \
        .with_content(/TARGET='root@localhost'/) \
        .with_content(/DELAY="-R 120"/)
                      
      should contain_file('/etc/patchmgmt.conf') \
        .with_content(/MAKE_YUM_CACHE="yes"/) \
        .with_content(/MAKE_YUM_UPDATES="yes"/)

      should contain_file('/etc/cron.d/patchmgmt') \
        .with_content(/0 10 * * mon root \/usr\/local\/sbin\/cleanupdates/)

      should contain_file('/usr/local/sbin/print_enabled_repos')
    end
  end
end
