actions :enable, :start, :stop, :restart
default_action :enable

attribute :service_name, :kind_of => String, :name_attribute => true
