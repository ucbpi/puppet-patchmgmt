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
        .with_content(/RUN_YUM_UPDATES="yes"/)

      should contain_file('/etc/cron.d/patchmgmt') \
        .with_content(/0 10 \* \* mon root \/usr\/local\/sbin\/cleanupdates/) \
        .with_content(/0 10 \* \* tue root \/usr\/local\/sbin\/listupdates/) \
        .with_content(/0 10 \* \* wed root \/usr\/local\/sbin\/runupdates/)

      should contain_file('/usr/local/sbin/print_enabled_repos')
    end
  end

  context "=> change target email addresses" do
    let(:params) {
      { 'patch_day' => 'wed',
        'patch_hour' => '10',
        'patch_email' => 'patch-notify@localhost',
        'list_day' => 'tue',
        'list_hour' => '10',
        'list_email' => 'list-notify@localhost',
        'clean_day' => 'mon',
        'clean_hour' => '10',
        'clean_email' => 'clean-notify@localhost' } }
    it do
      should contain_file('/usr/local/sbin/runupdates') \
        .with_content(/TARGET='patch-notify@localhost'/) \
        .with_content(/DELAY="-R 120"/)

      should contain_file('/usr/local/sbin/listupdates') \
        .with_content(/TARGET='list-notify@localhost'/) \
        .with_content(/DELAY="-R 120"/)

      should contain_file('/usr/local/sbin/cleanupdates') \
        .with_content(/TARGET='clean-notify@localhost'/) \
        .with_content(/DELAY="-R 120"/) 
                      
      should contain_file('/etc/patchmgmt.conf') \
        .with_content(/MAKE_YUM_CACHE="yes"/) \
        .with_content(/RUN_YUM_UPDATES="yes"/)

      should contain_file('/etc/cron.d/patchmgmt') \
        .with_content(/0 10 \* \* mon root \/usr\/local\/sbin\/cleanupdates/) \
        .with_content(/0 10 \* \* tue root \/usr\/local\/sbin\/listupdates/) \
        .with_content(/0 10 \* \* wed root \/usr\/local\/sbin\/runupdates/)

      should contain_file('/usr/local/sbin/print_enabled_repos')
    end
  end

  context "=> disable patching" do
    let(:params) {
      { 'patch_day' => 'wed',
        'patch_hour' => '10',
        'patch_email' => 'patch-notify@localhost',
        'patch' => false,
        'list_day' => 'tue',
        'list_hour' => '10',
        'list_email' => 'list-notify@localhost',
        'clean_day' => 'mon',
        'clean_hour' => '10',
        'clean_email' => 'clean-notify@localhost' } }
    it do
      should contain_file('/usr/local/sbin/runupdates') \
        .with_content(/TARGET='patch-notify@localhost'/) \
        .with_content(/DELAY="-R 120"/)

      should contain_file('/usr/local/sbin/listupdates') \
        .with_content(/TARGET='list-notify@localhost'/) \
        .with_content(/DELAY="-R 120"/)

      should contain_file('/usr/local/sbin/cleanupdates') \
        .with_content(/TARGET='clean-notify@localhost'/) \
        .with_content(/DELAY="-R 120"/) 
                      
      should contain_file('/etc/patchmgmt.conf') \
        .with_content(/MAKE_YUM_CACHE="yes"/) \
        .with_content(/RUN_YUM_UPDATES="no"/)

      should contain_file('/etc/cron.d/patchmgmt') \
        .with_content(/0 10 \* \* mon root \/usr\/local\/sbin\/cleanupdates/) \
        .with_content(/0 10 \* \* tue root \/usr\/local\/sbin\/listupdates/) \
        .with_content(/0 10 \* \* wed root \/usr\/local\/sbin\/runupdates/)

      should contain_file('/usr/local/sbin/print_enabled_repos')
    end
  end

  context "=> disable cleaning" do
    let(:params) {
      { 'patch_day' => 'wed',
        'patch_hour' => '10',
        'patch_email' => 'patch-notify@localhost',
        'list_day' => 'tue',
        'list_hour' => '10',
        'list_email' => 'list-notify@localhost',
        'clean' => false,
        'clean_day' => 'mon',
        'clean_hour' => '10',
        'clean_email' => 'clean-notify@localhost' } }
    it do
      should contain_file('/usr/local/sbin/runupdates') \
        .with_content(/TARGET='patch-notify@localhost'/) \
        .with_content(/DELAY="-R 120"/)

      should contain_file('/usr/local/sbin/listupdates') \
        .with_content(/TARGET='list-notify@localhost'/) \
        .with_content(/DELAY="-R 120"/)

      should contain_file('/usr/local/sbin/cleanupdates') \
        .with_content(/TARGET='clean-notify@localhost'/) \
        .with_content(/DELAY="-R 120"/) 
                      
      should contain_file('/etc/patchmgmt.conf') \
        .with_content(/MAKE_YUM_CACHE="no"/) \
        .with_content(/RUN_YUM_UPDATES="yes"/)

      should contain_file('/etc/cron.d/patchmgmt') \
        .with_content(/0 10 \* \* mon root \/usr\/local\/sbin\/cleanupdates/) \
        .with_content(/0 10 \* \* tue root \/usr\/local\/sbin\/listupdates/) \
        .with_content(/0 10 \* \* wed root \/usr\/local\/sbin\/runupdates/)

      should contain_file('/usr/local/sbin/print_enabled_repos')
    end
  end
end
