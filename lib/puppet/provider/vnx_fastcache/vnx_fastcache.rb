begin
  require 'puppet_x/puppetlabs/transport/emc_vnx'
rescue LoadError => e
  require 'pathname' # WORK_AROUND #14073 and #7788
  module_lib = Pathname.new(__FILE__).parent.parent.parent
  puts "MODULE LIB IS #{module_lib}"
  require File.join module_lib, 'puppet_x/puppetlabs/transport/emc_vnx'
end

Puppet::Type.type(:vnx_fastcache).provide(:vnx_fastcache) do
  include PuppetX::Puppetlabs::Transport::EMCVNX

  desc "Manages VNX FAST Cache settings."
  
#  $ioClass = [] 
#  $iNumIOClass = 0
  
  mk_resource_property_methods

  def initialize *args
    super
    @property_flush = {}
  end

  def get_current_properties
    fastcache_info = run(["cache", "-fast", "-info"])
    self.class.get_fastcache_properties fastcache_info
  end

  def self.get_fastcache_properties fastcache_info
    fastcache = {}
    fastcache_info.split("\n").each do |line|

      if (pattern = "Disks:") && line.start_with?(pattern)
        fastcache[:disks] = line.sub(pattern, "").strip
        next
      end

      if (pattern = "Mode:") && line.start_with?(pattern)
        fastcache[:mode] = line.sub(pattern, "").strip
        next
      end

      if (pattern = "Raid Type:") && line.start_with?(pattern)
        fastcache[:raid_type] = line.sub(pattern, "").strip
        next
      end

      if (pattern = "Size (GB):") && line.start_with?(pattern)
        fastcache[:size] = line.sub(pattern, "").strip.to_i
        next
      end

      if (pattern = "State:") && line.start_with?(pattern)
        fastcache[:state] = line.sub(pattern, "").strip.to_i
        next
      end

      if (pattern = "Current Operation:") && line.start_with?(pattern)
        fastcache[:current_ope] = line.sub(pattern, "").strip.to_i
        next
      end

      if (pattern = "Current Operation Status:") && line.start_with?(pattern)
        fastcache[:current_ope_status] = line.sub(pattern, "").strip
        next
      end

      if (pattern = "Current Operation Percent Completed:") && line.start_with?(pattern)
        fastcache[:current_ope_per_comp] = line.sub(pattern, "").strip
        next
      end

      if (pattern = "Percentage Dirty SPA:") && line.start_with?(pattern)
        fastcache[:per_dirty_spa] = line.sub(pattern, "").strip
        next
      end

      if (pattern = "MBs Flushed SPA:") && line.start_with?(pattern)
        fastcache[:mbs_flushed_spa] = line.sub(pattern, "").strip
        next
      end

      if (pattern = "Percentage Dirty SPB:") && line.start_with?(pattern)
        fastcache[:per_dirty_spb] = line.sub(pattern, "").strip
        next
      end

      if (pattern = "MBs Flushed SPB:") && line.start_with?(pattern)
        fastcache[:mbs_flushed_spb] = line.sub(pattern, "").strip
        next
      end

    end
    fastcache[:ensure] = :present
    fastcache
  end

  # assume exists should be first called
  def exists?
    current_properties[:ensure] == :present
  end


  def create_fastcache
    args = ["cache", "-create", "-disks", *resource[:disks], "-mode", resource[:cache_mode], "-rtype", resource[:raid_type]]
#    args << "-disks" << *resource[:disks]
#    args << "-mode" << resource[:cache_mode]
#    args << "-rtype" << resource[:raid_type]
     puts "tohdat debug #{args}"
    run(args)
#    $ioClass[$iNumIOClass]="#{resource[:ioclass]}"
#    $iNumIOClass=$iNumIOClass+1

   # out_ioclasses = `echo #{resource[:ioclass]} >> /tmp/#{resource[:policy_name]}.txt`
   # out_ioclasses
    @property_hash[:ensure] = :present
  end

  def modify_ioclass
#    args = ['nqm', '-ioclass', '-modify', '-name', resource[:ioclass]]
#    origin_length = args.length
#    args << "-iotype" << resource[:io_type]
#    args << "-anyio" if resource[:anyio]
#    args << "-luns" << resource[:lun_number]
#    args << "-ctrlmethod" << resource[:control_method]
#    args << "-gmetric" << resource[:metric_type]
#    args << "-gval" << resource[:goal_value]
#    run(args)
#    $ioClass[$iNumIOClass]="#{resource[:ioclass]}"
#    $iNumIOClass=$iNumIOClass+1
    @property_hash[:ensure] = :present
  end

 # def get_file_as_string(filename)
 #   data = ''
 #   f = File.open(filename, "r") 
 #   f.each_line do |line|
 #     data += line
 #   end
 #   return data
 # end

  def create_policy
  #  f_name = "/tmp/" + resource[:policy_name] + ".txt"
  #  ioclass_list = get_file_as_string(f_name)
  #  ioclass_list = ioclass_list.gsub("\n", ' ')
    #args = ['nqm', '-policy', '-create', '-name', resource[:policy_name], '-ioclasses', *$ioClass]
    #args << "-ioclasses" << ioclass_list
    #puts "wzz debug #{$ioClass.join(' ')}"
    #puts "wzz debug #{args}"
    #args << "-ioclasses" << $ioClass.join(' ')
    #puts "wzz debug #{args}"
    #args << "-failaction" << resource[:fail_action]
    #run(args)
    @property_hash[:ensure] = :present
  end

  def modify_policy
    #args = ['nqm', '-policy', '-modify', '-name', resource[:policy_name]]
    #args << "-ioclasses" << resource[:ioclass]
    #args << "-failaction" << resource[:fail_action]
    #run(args)
    @property_hash[:ensure] = :present
  end

  def run_policy
    #args = ['nqm', '-run', resource[:policy_name]]
    #run(args)
    @property_hash[:ensure] = :present
  end

  def create
    @property_flush[:ensure] = :present
  end

  def destroy
    @property_flush[:ensure] = :absent
  end

  def flush
    # destroy
    if @property_flush[:ensure] == :absent
      args = ["cache", "-fast", "-destroy"]
#      args << "-name" << resource[:ioclass]
      args << "-o"
      run args
      @property_hash[:ensure] = :absent
      return
    end

    if exists?
      modify_ioclass
    else
#      if resource[:ioclass]
        create_fastcache
#      else
#		create_policy
#		run_policy
#      end

    end
  end
end
