class vosupport (
  $supported_vos                = $vosupport::params::supported_vos,
  $enable_poolaccounts          = $vosupport::params::enable_poolaccounts,
  $enable_mkgridmap_for_service = 
  $vosupport::params::enable_mkgridmap_for_service,
  $enable_mappings_for_service  = 
  $vosupport::params::enable_mappings_for_service,
  $enable_environment           = $vosupport::params::enable_environment,
  $enable_voms                  = $vosupport::params::enable_voms,
  $enable_gridmapdir_for_group  = 
  $vosupport::params::enable_gridmapdir_for_group,
  $vomappingdata                = $vosupport::params::vomappingdata,
  $poolaccounts                 = $vosupport::params::poolaccounts,
  $vomsservers                  = $vosupport::params::vomsservers,
  $configfile                   = $vosupport::params::configfile,) {
  include concat::setup

  file { 'grid-env-funcs.sh':
    path   => '/usr/libexec/grid-env-funcs.sh',
    source => 'puppet:///modules/vosupport/grid-env-funcs.sh',
    owner  => 'root',
    group  => 'root',
    mode   => 0644,
  }

  file { 'clean-grid-env-funcs.sh':
    path   => '/usr/libexec/clean-grid-env-funcs.sh',
    source => 'puppet:///modules/vosupport/clean-grid-env-funcs.sh',
    owner  => 'root',
    group  => 'root',
    mode   => 0644,
  }

  # create gridmapdir if necessary
  if $enable_gridmapdir_for_group != undef {
    file { '/etc/grid-security/gridmapdir':
      ensure  => directory,
      mode    => 0770,
      owner   => root,
      group   => $enable_gridmapdir_for_group,
      require => File['/etc/grid-security']
    }
  }

  #
  # overall process:
  #

  # get metadata from hiera
  # hash voname => { vohomedef => [ role definition array ] }
  # we want to create poolaccounts::setuphome for each role definition in the
  # VOs listed in $supported_vos

  # 1. create virtual resources for each VO from hiera.
  # 2. Each virtual resource will define a poolaccounts::setuphome for each role
  # definition
  # 3. we realize the VO resources that match $supported_vos

  # enable the list of supported VOs from the class parameters (most likely
  # coming from hiera)
  # for create_resources to be happy we need to convert the  $supported_vos
  # array into a hash
  # i.e. yaml that looks like "{ vo1: {}, vo2: {}, etc. }"
  $supported_vos_hash   = parseyaml(inline_template('{ <%= @supported_vos.collect{ |voname| voname + \': {}\' }.join(\', \') %>} '
  ))

  # set defaults
  $supported_vos_params = {
    enable_poolaccounts          => $enable_poolaccounts,
    enable_mappings_for_service  => $enable_mappings_for_service,
    enable_mkgridmap_for_service => $enable_mkgridmap_for_service,
    enable_environment           => $enable_environment,
    enable_voms                  => $enable_voms,
    enable_gridmapdir            => $enable_gridmapdir_for_group ? {
      undef   => false,
      default => true
    },
    vomappingdata                => $vomappingdata,
    poolaccounts                 => $poolaccounts,
    vomsservers                  => $vomsservers,
    configfile                   => $configfile,
  }
  create_resources('vosupport::enable_vo', $supported_vos_hash, 
  $supported_vos_params)
}
