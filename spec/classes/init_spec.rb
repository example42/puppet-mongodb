require 'spec_helper'

describe 'mongodb' do

  context 'Supported OS - ' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "#{osfamily} standard installation" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it { should contain_package('mongodb').with_ensure('present') }
        it { should contain_service('mongodb').with_ensure('running') }
      end

      describe "#{osfamily} installation of a specific package version" do
        let(:params) { {
          :package_ensure => '1.0.42',
        } }
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it { should contain_package('mongodb').with_ensure('1.0.42') }
      end

      describe "#{osfamily} removal of package installation" do
        let(:params) { {
          :package_ensure => 'absent',
        } }
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it 'should remove Package[mongodb]' do should contain_package('mongodb').with_ensure('absent') end
        it 'should stop Service[mongodb]' do should contain_service('mongodb').with_ensure('stopped') end
        it 'should not manage at boot Service[mongodb]' do should contain_service('mongodb').with_enable(nil) end
        it 'should remove mongodb configuration file' do should contain_file('mongodb.conf').with_ensure('absent') end
      end

      describe "#{osfamily} service disabling" do
        let(:params) { {
          :service_ensure => 'stopped',
          :service_enable => false,
        } }
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it 'should stop Service[mongodb]' do should contain_service('mongodb').with_ensure('stopped') end
        it 'should not enable at boot Service[mongodb]' do should contain_service('mongodb').with_enable('false') end
      end

      describe "#{osfamily} configuration via custom template" do
        let(:params) { {
          :config_file_template     => 'mongodb/spec.conf',
          :config_file_options_hash => { 'opt_a' => 'value_a' },
        } }
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it { should contain_file('mongodb.conf').with_content(/This is a template used only for rspec tests/) }
        it 'should generate a template that uses custom options' do
          should contain_file('mongodb.conf').with_content(/value_a/)
        end
      end

      describe "#{osfamily} configuration via custom content" do
        let(:params) { {
          :config_file_content    => 'my_content',
        } }
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it { should contain_file('mongodb.conf').with_content(/my_content/) }
      end

      describe "#{osfamily} configuration via custom source file" do
        let(:params) { {
          :config_file_source => "puppet:///modules/mongodb/spec.conf",
        } }
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it { should contain_file('mongodb.conf').with_source('puppet:///modules/mongodb/spec.conf') }
      end

      describe "#{osfamily} configuration via custom source dir" do
        let(:params) { {
          :config_dir_source => 'puppet:///modules/mongodb/tests/',
          :config_dir_purge => true
        } }
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it { should contain_file('mongodb.dir').with_source('puppet:///modules/mongodb/tests/') }
        it { should contain_file('mongodb.dir').with_purge('true') }
        it { should contain_file('mongodb.dir').with_force('true') }
      end

      describe "#{osfamily} service restart on config file change (default)" do
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it 'should automatically restart the service when files change' do
          should contain_file('mongodb.conf').with_notify('Service[mongodb]')
        end
      end

      describe "#{osfamily} service restart disabling on config file change" do
        let(:params) { {
          :config_file_notify => '',
        } }
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it 'should automatically restart the service when files change' do
          should contain_file('mongodb.conf').without_notify
        end
      end

    end
  end

  context 'Unsupported OS - ' do
    describe 'Not supported operating systems should throw and error' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end

end

