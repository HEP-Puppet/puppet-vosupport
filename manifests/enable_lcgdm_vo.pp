define vosupport::enable_lcgdm_vo (
   $voname=$name,
   $unprivilegedmkgridmap=false,
   $gridservice="LFC"
)
{
   include vosupport::params
   $configfile    = "/etc/lcgdm-mkgridmap.conf"

   concat::fragment{"${voname}_lcgdmmkgridmapconf":
     target  => $configfile,
     order   => "08",
     content => template('vosupport/lcgdm-mkgridmap.conf.erb'),
   }

}

