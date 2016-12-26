class puppetvnx::vnx_cmds{

#  define vnx_createLUN{
#    include set_vnx
#    include vnx_transport
#    $val = split($name, ',')
#
#    vnx_lun { "Create: ${val[4]}":
#      ensure => present,
#      type => "${val[0]}",
#      capacity => "${val[1]}",
#      pool_id => "${val[2]}",
#      lun_number => "${val[3]}",
#      lun_name => "${val[4]}",
#      transport => Transport['VNX'],
#      notify => Exec["vnx_createLUN $name result"]
#    }
#    exec { "vnx_createLUN $name result":
#      command => "echo `date` : vnx_createLUN $name >> $set_vnx::result_file",
#      path => "/bin/",
#      refreshonly => true
#    }
#  }

  define vnx_createLUN{
    include puppetvnx::set_vnx
    include puppetvnx::vnx_transport
    $val = split($name, ',')

    vnx_lun { "Create${val[5]}":
      ensure => present,
      type => "${val[0]}",
      capacity => "${val[1]}",
      size_qual => "${val[2]}",
      pool_name => "${val[3]}",
      default_owner => "${val[4]}",
      lun_number => "${val[5]}",
      ignore_thresholds => "${val[6]}",
      lun_name => "${val[7]}",
      transport => Transport['VNX'],
      notify => Exec["vnx_createLUN $name result"]
    }
    exec { "vnx_createLUN $name result":
      command => "echo `date` : vnx_createLUN $name >> $puppetvnx::set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

  define vnx_deleteLUN{
    include set_vnx
    include vnx_transport
    $val = split($name, ',')

    vnx_lun { "Delete: ${val[4]}":
      ensure => absent,
      lun_name => "${val[4]}",
      transport => Transport['VNX'],
      notify => Exec["vnx_deleteLUN $name result"]
    }
    exec { "vnx_deleteLUN $name result":
      command => "echo `date` : vnx_deleteLUN $name >> $set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

  define vnx_createSG{
    include puppetvnx::set_vnx
    include puppetvnx::vnx_transport

    vnx_storagegroup { "Create: $name":
      ensure => present,
      sg_name => "$name",
      transport => Transport['VNX'],
      notify => Exec["vnx_createSG $name result"]
    }
    exec { "vnx_createSG $name result":
      command => "echo `date` : vnx_createSG $name >> $puppetvnx::set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

  define vnx_deleteSG{
    include set_vnx
    include vnx_transport

    vnx_storagegroup { "Delete: $name":
      ensure => absent,
      sg_name => "$name",
      transport => Transport['VNX'],
      notify => Exec["vnx_deleteSG $name result"]
    }
    exec { "vnx_deleteSG $name result":
      command => "echo `date` : vnx_deleteSG $name >> $set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

  define vnx_addLUN{
    include puppetvnx::set_vnx
    include puppetvnx::vnx_transport
    $val = split($name, ',')

    vnx_storagegroup { "Add: $name":
      ensure => present,
      sg_name =>  "${val[0]}",
      luns => [ {'hlu' => "${val[2]}", 'alu' => "${val[1]}"} ],
      transport => Transport['VNX'],
      notify => Exec["vnx_addLUN $name result"]
    }
    exec { "vnx_addLUN $name result":
      command => "echo `date` : vnx_addLUN $name >> $puppetvnx::set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

  define vnx_removeLUN{
    include set_vnx
    include vnx_transport
    $val = split($name, ',')

    vnx_storagegroup { "Remove: $name":
      ensure => absent,
      sg_name =>  "${val[0]}",
      luns => [ {'hlu' => "${val[2]}", 'alu' => "${val[1]}"} ],
      transport => Transport['VNX'],
      notify => Exec["vnx_removeLUN $name result"]
    }
    exec { "vnx_removeLUN $name result":
      command => "echo `date` : vnx_removeLUN $name >> $set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

#  define vnx_setPATH{
#    include set_vnx
#    include vnx_transport
#    $val = split($name, ',')
#
#    vnx_storagegroup { "Set: $name":
#      ensure => present,
#      setpathonly => true,
#      hbauid =>  "${val[0]}",
#      sp =>  "${val[1]}",
#      sp_port =>  "${val[2]}",
#      initiator_type =>  "${val[3]}",
#      ip_address =>  "${val[4]}",
#      hostname =>  "${val[5]}",
#      failover_mode =>  "${val[6]}",
#      array_commpath =>  "${val[7]}",
#      unit_serialnumber =>  "${val[8]}",
#      transport => Transport['VNX'],
#      notify => Exec["vnx_setPATH $name result"]
#    }
#    exec { "vnx_setPATH $name result":
#      command => "echo `date` : vnx_setPATH $name >> $set_vnx::result_file",
#      path => "/bin/",
#      refreshonly => true
#    }
#  }

  define vnx_setPATH{
    include puppetvnx::set_vnx
    include puppetvnx::vnx_transport
    $val = split($name, ',')
    vnx_initiator { "setPath: $name":
      ensure => present,
      #sg_name =>  "${val[0]}",
      #addonly => true,
      hba_uid => "${val[0]}",
      hostname => "${val[5]}",
      ip_address => "${val[4]}",
      ports => [ {'sp' => "${val[1]}", 'sp_port' => "${val[2]}"} ],
      failovermode => "${val[6]}",
      arraycommpath => "${val[7]}",
      transport => Transport['VNX'],
      notify => Exec["vnx_setPath $name result"]
    }
    exec { "vnx_setPath $name result":
      command => "echo `date` : vnx_setPath $name >> $puppetvnx::set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

  define vnx_addHost{
    include puppetvnx::set_vnx
    include puppetvnx::vnx_transport
    $val = split($name, ',')

    vnx_storagegroup { "Add: ${val[0]}":
      ensure => present,
      addonly => true,
      host_name =>  "${val[0]}",
      sg_name =>  "${val[1]}",
      transport => Transport['VNX'],
      notify => Exec["vnx_addHost $name result"]
    }
    exec { "vnx_addHost $name result":
      command => "echo `date` : vnx_addHost $name >> $puppetvnx::set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

  define vnx_setNQMioclasses{
    include set_vnx
    include vnx_transport
    $val = split($name, ',')

    vnx_nqm { "Set: $name":
      ensure => present,
      ioclass => "${val[0]}",
      lun_number => "${val[1]}",
      io_type => "${val[2]}",
      anyio => "${val[3]}",
      control_method => "${val[4]}",
      metric_type => "${val[5]}",
      goal_value => "${val[6]}",
      policy_name => "${val[7]}",
      transport => Transport['VNX'],
      notify => Exec["vnx_setQOS $name result"]
    }
    exec { "vnx_setQOS $name result":
      command => "echo `date` : vnx_setQOS $name >> $set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

  define vnx_deleteNQMioclasses{
    include set_vnx
    include vnx_transport
    $val = split($name, ',')

    vnx_nqm { "Set: $name":
      ensure => absent,
      ioclass => "${val[0]}",
      transport => Transport['VNX'],
      notify => Exec["vnx_deleteNQM $name result"]
    }
    exec { "vnx_deleteNQM $name result":
      command => "echo `date` : vnx_deleteNQM $name >> $set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

  define vnx_setNQMpolicy{
    include set_vnx
    include vnx_transport
    $val = split($name, ',')

    vnx_nqm { "Set Policy: $name":
      ensure => present,
      policy_name => "${val[0]}",
      fail_action => "${val[1]}",
      transport => Transport['VNX'],
      notify => Exec["vnx_setQOS $name result"]
    }
    exec { "vnx_setQOS $name result":
      command => "echo `date` : vnx_setQOS $name >> $set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }


  define vnx_createPool{
    include set_vnx
    include vnx_transport
    $val1 = split($name, ';')
    $val2 = split("${val1[0]}", ',')

    vnx_storagepool { "Create: $name":
      ensure => present,
      disks => $val2,
      raid_type => "${val1[1]}",
      rdrive_count => "${val1[2]}",
      name => "${val1[3]}",
      auto_tiering => "${val1[5]}",
      ensure_fastcache => "${val1[6]}",
      skip_rules => "${val1[7]}",
      transport => Transport['VNX'],
      notify => Exec["vnx_createPool $name result"]
    }
    exec { "vnx_createPool $name result":
      command => "echo `date` : vnx_createPool $name >> $set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

  define vnx_createFASTCache{
    include set_vnx
    include vnx_transport
    $val1 = split($name, ';')
    $val2 = split("${val1[0]}", ',')

    vnx_fastcache { "Create: ${val1[0]}":
      ensure => present,
      disks => $val2,
      cache_mode => "${val1[1]}",
      raid_type => "${val1[2]}",
      transport => Transport['VNX'],
      notify => Exec["vnx_createFASTCache $name result"]
    }
    exec { "vnx_createFASTCache $name result":
      command => "echo `date` : vnx_createFASTCache $name >> $set_vnx::result_file",
      path => "/bin/",
      refreshonly => true
    }
  }

}
