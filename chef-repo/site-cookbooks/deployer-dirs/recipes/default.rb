bash 'Prepare dirs permissions' do
  user 'root'
  code <<-EOC
    TORQUEBOX_HOME="/usr/local/rbenv/versions/jruby-1.7.8/lib/ruby/gems/shared/gems/torquebox-server-3.0.1-java"
    chown -R deployer:sysadmin  $TORQUEBOX_HOME/jboss/standalone/deployments/
    chmod -R 755 $TORQUEBOX_HOME/jboss/standalone/deployments/
  EOC
end