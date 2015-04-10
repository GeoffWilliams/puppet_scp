require 'puppet/parameter/boolean'

Puppet::Type.newtype(:scp) do
  @doc = "SCP a file"

  ensurable do
    desc "Create or remove the scp'ed file"
    defaultvalues
    defaultto(:present)
  end

  newparam(:source) do
    desc "The source argument to SCP"   
    isrequired
  end

  newparam(:name) do
    desc "The local file to save to (destination argument to SCP)"
    validate do |value|
      unless Puppet::Util.absolute_path?(value)
        fail Puppet::Error, "File paths must be fully qualified, not '#{value}'"
      end
    end
  end
  
  newparam(:verify, :boolean => true, :parent => Puppet::Parameter::Boolean) do
    desc "Enable/disable remote md5 validation using SSH"
    defaultto(true)
  end
  
  
  
  # require any parent directory be created first
  autorequire :file do
    [ File.dirname(self[:name]) ]
  end

end