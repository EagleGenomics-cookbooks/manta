#
# Cookbook Name:: manta
# Recipe:: default
#
# Copyright 2016 Eagle Genomics Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'apt'
include_recipe 'build-essential'

package ['tar', 'zlib1g-dev'] do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['manta']['filename']}" do
  source node['manta']['url']
end

execute "Untar #{node['manta']['filename']}" do
  command "tar -xjf #{node['manta']['filename']}"
  cwd Chef::Config[:file_cache_path]
  not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/#{node['manta']['dirname']}") }
end

directory "#{Chef::Config[:file_cache_path]}/build" do
end

bash 'Install manta' do
  cwd "#{Chef::Config[:file_cache_path]}/build"
  code <<-EOH
    ../manta-#{node['manta']['version']}.release_src/configure --jobs=4 --prefix=#{node['manta']['install_path']}
    make -j4 install
  EOH
  not_if { ::File.exist?("#{node['manta']['install_path']}/bin/manta") }
end
