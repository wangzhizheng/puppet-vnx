class puppetvnx::vnx_transport{
  include puppetvnx::set_vnx
  transport { 'VNX':
    server => $puppetvnx::set_vnx::spa,
    username => $puppetvnx::set_vnx::username,
    password => $puppetvnx::set_vnx::password,
  }
}
