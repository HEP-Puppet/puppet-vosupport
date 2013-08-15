# parameter set for the vosupport module
class vosupport::params {
  # list of supported VOs we want to enable
  $supported_vos                = hiera("vosupport_supported_vos", [])
  # whether to create pool accounts
  $enable_poolaccounts          = hiera("vosupport_enable_poolaccounts", True)
  # a service to enable mkgridmap for (LFC...)
  $enable_mkgridmap_for_service = hiera("vosupport_enable_mkgridmap_for_service", 
  undef)
  # a service to enable mappings for (WMS, ARGUS...)
  $enable_mappings_for_service  = hiera("vosupport_enable_mappings_for_service", 
  undef)
  # whether to set up the gridenv for these VOs
  $enable_environment           = hiera("vosupport_enable_environment", True)
  # whether to enable VOMS client for these VOs
  $enable_voms                  = hiera("vosupport_enable_voms", True)
  # if specified, create and populate gridmapdir with pool accounts and sets the
  # ownership of the gridmapdir to the specified group name
  $enable_gridmapdir_for_group  = hiera("vosupport_enable_gridmapdir_for_group", 
  undef)

  $poolaccounts                 = hiera_hash('vosupport::poolaccounts', undef)

  $vo2gidmap                    = hiera("vo2gidmap", undef)

  # create file fragments for the specified VO and service
  $vomappingdata                = hiera_hash('vosupport::mappings', undef)

  $vomsservers                  = hiera_hash('vosupport::vomsservers', undef)

  $configfile                   = "/etc/lcgdm-mkgridmap.conf"

  $voenvdefaults                = hiera_hash('vosupport::voenv', undef)
}