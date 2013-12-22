package 'chkconfig'
package 'curl'
package 'libcurl3'
package 'libcurl3-dev'
package 'libmagickwand-dev'
package 'imagemagick'
package 'zip'
package 'postgresql-client'

bash 'Prepare dirs permissions' do
  user 'root'
  code <<-EOC
    mkdir -p /etc/jboss-as/
  EOC
end


cookbook_file "/etc/init.d/jboss-as-standalone" do
  mode 0755
end

cookbook_file "/etc/jboss-as/jboss-as.conf" do
  mode 0755
end



#Create torquebox user and make owner

bash 'Prepare dirs permissions' do
  user 'root'
  code <<-EOC
    useradd torquebox_user
    mkdir -p /home/torquebox_user
    mkdir -p /var/log/torquebox/
    chown -R torquebox_user. /home/torquebox_user
    TORQUEBOX_HOME="/usr/local/rbenv/versions/jruby-1.7.8/lib/ruby/gems/shared/gems/torquebox-server-3.0.1-java"
    chown -R torquebox_user.  $TORQUEBOX_HOME
    chmod -R 755 $TORQUEBOX_HOME/jboss/standalone/deployments/    
  EOC
end


#deploy backstage gem 
bash 'deploy backstage gem' do
  user 'root'
  code <<-EOC
    PATH="/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
    TORQUEBOX_HOME="/usr/local/rbenv/versions/jruby-1.7.8/lib/ruby/gems/shared/gems/torquebox-server-3.0.1-java"
    BACKSTAGE_HOME="/usr/local/rbenv/versions/jruby-1.7.8/lib/ruby/gems/shared/gems/torquebox-backstage-1.1.0" 
    TORQUEBOX_HOME=$TORQUEBOX_HOME $BACKSTAGE_HOME/bin/backstage deploy
  EOC
end

# Start server
service "jboss-as-standalone" do
  supports :restart => true, :reload => true
  action :enable
end