# encoding: utf-8

# Fetch Aurora RPM artifacts if the installation method is 'rpm'
if node['aurora']['package']['rhel']['install_method'] == 'rpm'
  base_url = 'https://bintray.com/artifact/download/apache/aurora/centos-7/'

  %w(scheduler executor).each do |sv|
    fname = "aurora-#{sv}-0.12.0-1.el7.centos.aurora.x86_64.rpm"
    remote_file fname do
      source base_url + fname
      mode '0755'
    end
  end
end
