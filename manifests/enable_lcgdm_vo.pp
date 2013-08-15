define vosupport::enable_lcgdm_vo (
  $voname                = $name,
  $unprivilegedmkgridmap = false,
  $gridservice           = 'LFC',
  $vomappingdata,
  $poolaccounts,
  $vomsservers,
  $configfile,) {
  concat::fragment { "${voname}_lcgdmmkgridmapconf":
    target  => $configfile,
    order   => '08',
    content => template('vosupport/lcgdm-mkgridmap.conf.erb'),
  }

}
