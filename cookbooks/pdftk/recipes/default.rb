#
# Cookbook Name:: pdftk
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  GCJ_VERSION='4.1.2'
  PDFTK_VERSION='1.41'

  # remote_file '/data/custom-binpkgs/32bit.tgz' do
  #   checksum '576d44d2f841d16f3701a1479ae295829daa7e39'
  #   owner 'root'
  #   group 'root'
  #   mode "0644"
  #   source 'http://static.brighterplanet.com/website/binaries/data_custom-binpkgs_32bit.tgz'
  # end
  
  execute "make sure there's a custom-binpkgs dir" do
    user 'root'
    command 'mkdir -p /data/custom-binpkgs'
  end

  execute "get the binpkgs archive" do
    user 'root'
    cwd '/data/custom-binpkgs'
    command 'curl -O http://static.brighterplanet.com/website/binaries/data_custom-binpkgs_32bit.tgz'
    not_if "openssl dgst -sha1 < data_custom-binpkgs_32bit.tgz | grep \"576d44d2f841d16f3701a1479ae295829daa7e39\""
  end

  execute "untar custom binpkgs" do
    user 'root'
    cwd '/data/custom-binpkgs'
    command "tar -xzf data_custom-binpkgs_32bit.tgz"
  end

  execute "make sure gcj #{GCJ_VERSION} is available" do
    user 'root'
    command "EMERGE_DEFAULT_OPTS=\"\" PKGDIR=\"/data/custom-binpkgs/32bit/\" emerge -K =sys-devel/gcc-#{GCJ_VERSION}"
    not_if "gcj --version | grep \"gcj (GCC) #{GCJ_VERSION}\""
  end

  execute "make sure pdftk #{PDFTK_VERSION} is available" do
    user 'root'
    command "EMERGE_DEFAULT_OPTS=\"\" PKGDIR=\"/data/custom-binpkgs/32bit/\" emerge -K =app-text/pdftk-#{PDFTK_VERSION}"
    not_if "pdftk --version | grep \"pdftk #{PDFTK_VERSION}\""
  end

end
