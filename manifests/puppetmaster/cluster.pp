# manifests/puppetmaster/cluster.pp

class puppet::puppetmaster::cluster inherits puppet::puppetmaster {
    include mongrel, nginx

    Service[puppetmaster]{
        require +> Service[ngnix],
    }

    File[puppet_config] {
        require => [ Package[mongrel], Package[nginx], File[nginx_config] ],
    }

    case $operatingsystem {
        gentoo, centos: {
            file{"/etc/init.d/puppetmaster":
                source => "puppet://$server/puppet/init.d/puppetmaster.${operatingsystem}",
                owner => root, group => 0, mode => 0755;
            }
        }
    }
}

