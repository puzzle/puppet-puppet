# manifests/puppetmaster/cluster.pp

class puppet::puppetmaster::cluster inherits puppet::puppetmaster {
    include puppet::puppetmaster::cluster::base

    case $operatingsystem {
        gentoo, centos: {
            file{"/etc/init.d/puppetmaster":
                source => "puppet://$server/puppet/cluster/init.d/puppetmaster.${operatingsystem}",
                owner => root, group => 0, mode => 0755;
            }
        }
    }
}

class puppet::puppetmaster::cluster::base inherits puppet::puppetmaster::base {
    include mongrel, nginx

    File[puppet_config] {
        require +> [ Package[mongrel], Package[nginx], File[nginx_config] ],
    }
}
