class puppet-vnx{
  import "vnx_definitions.pp"
  import "work_parameters.pp"
  include set_vnx_params

#  vnx_cmds::vnx_createPool{$set_vnx_params::storagepoollist:}
  vnx_cmds::vnx_createSG{$set_vnx_params::sgnames:}
  vnx_cmds::vnx_setPATH{$set_vnx_params::hostinitiator:}
  vnx_cmds::vnx_createLUN{$set_vnx_params::lunlist:}
  vnx_cmds::vnx_addLUN{$set_vnx_params::sglun:}
  vnx_cmds::vnx_addHost{$set_vnx_params::sghost:}
}
