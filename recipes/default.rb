include_recipe 'apache2'
include_recipe 'apache2::mod_php5'

package "zip" do
  action :install
end

source_file_name = "harviewer-#{node['harviewer']['version']}.zip"
source_url = "#{File.join(node['harviewer']['download_url'], source_file_name)}"

directory "/var/www/html" do
  owner "www-data"
  group "www-data"
  action :create
end

remote_file "/var/www/html/harviewer.zip" do
  source source_url
  notifies :run, "execute[extract_harviewer]", :immediately
end

execute "extract_harviewer" do
  command "cd /var/www/html/ && unzip harviewer.zip"
  action :nothing
end
