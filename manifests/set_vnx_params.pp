class puppetvnx::set_vnx_params{

#  $sgnames = [
#    #SG name
#    "momo_sg1",
#    "momo_sg2",
#    "momo_sg3"
#  ]

  $sgnames = [
    #SG name
    "emc-Cluster01a",
#    "emc-Cluster01b",
#    "emc-Cluster01c",
#    "emc-Cluster01d"
  ]

 #  $lunlist = [
 #   #Type, Size(GB), Pool ID, ALU, Lun Name
 #   "thin,10,0,411,puppet_lun1",
 #   "thin,20,0,412,puppet_lun2",
 #   "thin,30,0,413,puppet_lun3",
 #   "thin,40,0,414,puppet_lun4",
 # ]

  $lunlist = [
    #Type, Capacity, Size qualifier, Pool Name, SP, LUN Number(ALU), ignoreThresholds, Name
    # "thin,10,gb,FreePool000,a,411,true",
    # "thin,10,gb,FreePool000,b,412,true",
    "thin,104857600,bc,FreePool000,a,413,true,LUN413",
    # "thin,104857600,bc,FreePool000,b,414,true"
  ]

#  $sglun = [
#    #SG name, ALU, HLU
#    "momo_sg1,3950,0",
#    "momo_sg1,3951,1",
#    "momo_sg2,3952,0",
#    "momo_sg3,3953,0"
#  ]

  $sglun = [
    #SG name, ALU, HLU
    "emc-Cluster01a,413,31",
    # "emc-Cluster01b,402,32",
    # "emc-Cluster01c,403,33",
    # "emc-Cluster01d,404,34"
  ]

  $hostinitiator = [
    #HBAUID, SP, SP Port, Initiator_Type, IP Address, Hostname, Failover mode, Array communication path, Unit serial number
    " iqn.1992-04.com.emc:cx.ckm00121900536.b8,B,8,3,10.195.14.1,emc-pbsv0001,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx01-55af9f0a,B,8,3,10.195.14.1,emc-pbsv0001,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx01-55af9f0a,A,9,3,10.195.14.1,emc-pbsv0001,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx01-55af9f0a,B,9,3,10.195.14.1,emc-pbsv0001,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx02-55af9f0b,A,8,3,10.195.14.2,emc-pbsv0002,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx02-55af9f0b,B,8,3,10.195.14.2,emc-pbsv0002,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx02-55af9f0b,A,9,3,10.195.14.2,emc-pbsv0002,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx02-55af9f0b,B,9,3,10.195.14.2,emc-pbsv0002,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx03-55af9f0c,A,8,3,10.195.14.3,emc-pbsv0003,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx03-55af9f0c,B,8,3,10.195.14.3,emc-pbsv0003,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx03-55af9f0c,A,9,3,10.195.14.3,emc-pbsv0003,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx03-55af9f0c,B,9,3,10.195.14.3,emc-pbsv0003,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx04-55af9f0d,A,8,3,10.195.14.4,emc-pbsv0004,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx04-55af9f0d,B,8,3,10.195.14.4,emc-pbsv0004,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx04-55af9f0d,A,9,3,10.195.14.4,emc-pbsv0004,4,1,ARRAY",
    # "iqn.1998-01.com.vmware:esx04-55af9f0d,B,9,3,10.195.14.4,emc-pbsv0004,4,1,ARRAY"
  ]

  $sghost = [
    #Host, SG name
    "emc-pbsv0001,emc-Cluster01a",
    # "emc-pbsv0002,emc-Cluster01b",
    # "emc-pbsv0003,emc-Cluster01c",
    # "emc-pbsv0004,emc-Cluster01d"
  ]

  $storagepoollist = [
    #Disks, RType, RDriveCount, Pool Name, PrcntFull Threshold, Auto Tiering, FAST Cache, SkipRules
    "0_1_4,1_0_4,0_1_5,1_0_5,0_1_6,1_0_6,0_1_7,1_0_7;r_6;8;pool_emc-vnx5300_1_data_block_mid-speed;70;scheduled;true;true"
  ]

  $ssdfastcache = [
    #Disks, Cache Mode, RType
    "0_1_7,0_1_8;rw;r_1"
  ]

}
