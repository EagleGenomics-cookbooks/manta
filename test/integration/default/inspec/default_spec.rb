
describe file('/usr/local/bin/runMantaWorkflowDemo.py') do
  it { should be_file }
  it { should be_executable }
end

describe file('/usr/local/bin/configManta.py') do
  it { should be_file }
  it { should be_executable }
end

describe command('python /usr/local/bin/configManta.py') do
  its('stdout') { should match 'Version: 1.0.3' }
  its('exit_status') { should eq 2 }
end

describe file('/usr/local/bin/configManta.py.ini') do
  it { should be_file }
end

describe file('/usr/local/share/demo/manta/expectedResults') do
  it { should be_directory }
end

describe file('/usr/local/share/demo/manta/expectedResults/somaticSV.vcf.gz') do
  it { should be_file }
end

describe file('/usr/local/share/demo/manta/data') do
  it { should be_directory }
end

# the following will use data from /usr/local/share/demo/manta/data to test the installation
describe command('python /usr/local/bin/runMantaWorkflowDemo.py') do
  its('stderr') { should match '\*\*\*\* Demo/verification successfully completed' }
  its('exit_status') { should eq 0 }
end

describe file('./MantaDemoAnalysis') do
  it { should be_directory }
end

describe file('./MantaDemoAnalysis/workflow.exitcode.txt') do
  it { should be_file }
  its('content') { should eq "0\n" }
end

describe file('./MantaDemoAnalysis/workspace') do
  it { should be_directory }
end

describe file('./MantaDemoAnalysis/workflow.error.log.txt') do
  it { should be_file }
  its('size') { should eq 0 }
end

describe file('./MantaDemoAnalysis/workflow.warning.log.txt') do
  it { should be_file }
  its('size') { should eq 0 }
end

describe file('./MantaDemoAnalysis/results') do
  it { should be_directory }
end

describe file('./MantaDemoAnalysis/runWorkflow.py') do
  it { should be_file }
  it { should be_executable }
end

describe file('./MantaDemoAnalysis/runWorkflow.py.config.pickle') do
  it { should be_file }
end
