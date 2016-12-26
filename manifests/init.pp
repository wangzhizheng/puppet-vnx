class puppetvnx{
#  import "vnx_definitions.pp"
#  import "work_parameters.pp"
   include puppetvnx::set_vnx_params

#  vnx_cmds::vnx_createPool{$set_vnx_params::storagepoollist:}
  #  puppetvnx::vnx_cmds::vnx_createSG{$puppetvnx::set_vnx_params::sgnames:}
   puppetvnx::vnx_cmds::vnx_setPATH{$puppetvnx::set_vnx_params::hostinitiator:}
  #  puppetvnx::vnx_cmds::vnx_createLUN{$puppetvnx::set_vnx_params::lunlist:}
  #  puppetvnx::vnx_cmds::vnx_addLUN{$puppetvnx::set_vnx_params::sglun:}
  #  puppetvnx::vnx_cmds::vnx_addHost{$puppetvnx::set_vnx_params::sghost:}
}
