#initialize VO gridmapdir virtual resources
class vosupport::vo_gridmapdir($poolaccounts = $vosupport::params::poolaccounts) inherits vosupport::params
{
  create_resources('vosupport::virtual_setupgridmapdir',$poolaccounts, {gridmapdir => '/etc/grid-security/gridmapdir'})
}
