#
# Cookbook:: node-server
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'node-server::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs nginx' do
      expect(chef_run).to install_package 'nginx'
    end 

    it 'starts the nginx' do
      expect(chef_run).to start_service 'nginx'
    end 

    it 'enables the nginx' do
      expect(chef_run).to enable_service 'nginx'
    end 


    it 'installs node' do
      expect(chef_run).to run_execute ("sh /tmp/node_installer")
    end 

    it 'downloads the nodejs installer'
      expect{chef_run}.to create_remote_file('/tmp/node_installer').with(source: 'https://deb.nodesource.com/setup_6.x')
    end  
    # it 'installs pm2' do
    #   expect(chef_run).to install_package 'pm2'
    # end 
    it 'upgrade node' do
      expect(chef_run).to upgrade_package('nodejs')
    end 
    it 'installs pm2 with npm' do
      expect(chef_run).to run_execute'npm install pm2 -g'
    end  

  end
end
