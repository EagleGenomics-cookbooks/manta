default['manta']['version'] = '1.0.0'
default['manta']['install_path'] = '/usr/local'
default['manta']['dirname'] = 'manta-' + default['manta']['version']
default['manta']['filename'] = "manta-#{node['manta']['version']}.release_src.tar.bz2"
default['manta']['url'] = "https://github.com/Illumina/manta/releases/download/v#{node['manta']['version']}/#{node['manta']['filename']}"
