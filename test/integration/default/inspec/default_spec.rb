
describe file('/usr/local/bin/') do
  it { should be_symlink }
end

describe file('/opt/manta-3.2.2/bin/manta') do
  it { should be_file }
  it { should be_executable }
end

describe command('manta') do
  its('stdout') { should match '1.0.0' }
end
