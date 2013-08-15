#initialize VO poolaccount virtual resources
class vosupport::vo_poolaccounts (
  $poolaccounts = $vosupport::params::poolaccounts) inherits vosupport::params
{
  include vosupport::uidmap
  package {'rubygem-ruby-net-ldap':
    ensure => present,
  }
  
  file {
    '/home':
      ensure => directory,
      owner   => root,
      group   => root,
      mode    => 0755,
  }
  
  file { [
    '/pool',
    '/pool/grid']:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0755,
  }
  
  file {'/home/grid':
    ensure  => link,
    target => '/pool/grid'
  }

  create_resources('vosupport::virtual_setuphome',$poolaccounts, {homeroot => '/pool/grid'})
}
