require "fileutils"
require "digest/md5"
Puppet::Type.type(:scp).provide(:scp) do
  desc "SCP support"

  commands  :scp => "scp",
            :ssh => "ssh"
  
  def exists?
    if File.file?(@resource[:name])
      if @resource[:verify]
        # split username@server:/foo/bar/baz into:
        # "username@server", "/foo/bar/baz"
        components = @resource[:source].split(":")
        md5_cmd = "md5sum #{components[1]} | awk '{print $1}' "
        remote_md5 = ssh(components[0], md5_cmd)
        local_md5 = Digest::MD5.file(@resource[:name])
        if remote_md5 == local_md5
          # file exists and matches remote
          exists = true
        else
          # file exists and is out of sync
          exists = false
        end
      else
        # file exists and no remote verify allowed
        exists = true
      end
    else
      # file doesn't exist
      exists = false
    end
    
    return exists
  end
  
  def create
    scp(resource[:source], resource[:name])
  end

  
  def destroy
    FileUtils.rm_rf(resource[:name])
  end
  
end