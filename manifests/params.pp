# == Class: nova::params
#
# These parameters need to be accessed from several locations and
# should be considered to be constant
class nova::params {

  case $::osfamily {
    'RedHat': {
      # package names
      $api_package_name              = 'openstack-nova-api'
      $cells_package_name            = 'openstack-nova-cells'
      $cert_package_name             = 'openstack-nova-cert'
      $common_package_name           = 'openstack-nova-common'
      $compute_package_name          = 'openstack-nova-compute'
      $conductor_package_name        = 'openstack-nova-conductor'
      $consoleauth_package_name      = 'openstack-nova-console'
      $doc_package_name              = 'openstack-nova-doc'
      $libvirt_package_name          = 'libvirt'
      $libvirt_daemon_package_prefix = 'libvirt-daemon-'
      $libvirt_nwfilter_package_name = 'libvirt-daemon-config-nwfilter'
      $network_package_name          = 'openstack-nova-network'
      $numpy_package_name            = 'numpy'
      $objectstore_package_name      = 'openstack-nova-objectstore'
      $scheduler_package_name        = 'openstack-nova-scheduler'
      $tgt_package_name              = 'scsi-target-utils'
      $vncproxy_package_name         = 'openstack-nova-novncproxy'
      $serialproxy_package_name      = 'openstack-nova-serialproxy'
      $spicehtml5proxy_package_name  = 'openstack-nova-console'
      $sqlite_package_name           = undef
      $pymysql_package_name          = undef
      $ceph_client_package_name      = 'ceph-common'
      $genisoimage_package_name      = 'genisoimage'
      # service names
      $api_service_name              = 'openstack-nova-api'
      $cells_service_name            = 'openstack-nova-cells'
      $cert_service_name             = 'openstack-nova-cert'
      $compute_service_name          = 'openstack-nova-compute'
      $conductor_service_name        = 'openstack-nova-conductor'
      $consoleauth_service_name      = 'openstack-nova-consoleauth'
      $libvirt_service_name          = 'libvirtd'
      $network_service_name          = 'openstack-nova-network'
      $objectstore_service_name      = 'openstack-nova-objectstore'
      $scheduler_service_name        = 'openstack-nova-scheduler'
      $tgt_service_name              = 'tgtd'
      $vncproxy_service_name         = 'openstack-nova-novncproxy'
      $serialproxy_service_name      = 'openstack-nova-serialproxy'
      $spicehtml5proxy_service_name  = 'openstack-nova-spicehtml5proxy'
      # redhat specific config defaults
      $root_helper                   = 'sudo nova-rootwrap'
      $lock_path                     = '/var/lib/nova/tmp'
      $nova_log_group                = 'nova'
      $nova_wsgi_script_path         = '/var/www/cgi-bin/nova'
      $nova_api_wsgi_script_source   = '/usr/lib/python2.7/site-packages/nova/wsgi/nova-api.py'
      case $::operatingsystem {
        'Fedora': {
          $special_service_provider = undef
        }
        'RedHat', 'CentOS', 'Scientific', 'OracleLinux': {
          if (versioncmp($::operatingsystemmajrelease, '7') < 0) {
            $messagebus_service_name = 'messagebus'
            $special_service_provider = 'init'
          } else {
            $messagebus_service_name = 'dbus'
            $special_service_provider = 'redhat'
          }
        }
        default: {
          $special_service_provider = 'init'
        }
      }
    }
    'Debian': {
      # package names
      $api_package_name             = 'nova-api'
      $cells_package_name           = 'nova-cells'
      $cert_package_name            = 'nova-cert'
      $common_package_name          = 'nova-common'
      $compute_package_name         = 'nova-compute'
      $conductor_package_name       = 'nova-conductor'
      $consoleauth_package_name     = 'nova-consoleauth'
      $doc_package_name             = 'nova-doc'
      $libvirt_package_name         = 'libvirt-bin'
      $network_package_name         = 'nova-network'
      $numpy_package_name           = 'python-numpy'
      $objectstore_package_name     = 'nova-objectstore'
      $scheduler_package_name       = 'nova-scheduler'
      $tgt_package_name             = 'tgt'
      $serialproxy_package_name     = 'nova-serialproxy'
      $sqlite_package_name          = 'python-pysqlite2'
      $pymysql_package_name         = 'python-pymysql'
      $ceph_client_package_name     = 'ceph'
      $genisoimage_package_name     = 'genisoimage'
      # service names
      $api_service_name             = 'nova-api'
      $cells_service_name           = 'nova-cells'
      $cert_service_name            = 'nova-cert'
      $compute_service_name         = 'nova-compute'
      $conductor_service_name       = 'nova-conductor'
      $consoleauth_service_name     = 'nova-consoleauth'
      $network_service_name         = 'nova-network'
      $objectstore_service_name     = 'nova-objectstore'
      $scheduler_service_name       = 'nova-scheduler'
      $vncproxy_service_name        = 'nova-novncproxy'
      $serialproxy_service_name     = 'nova-serialproxy'
      $tgt_service_name             = 'tgt'
      $nova_log_group               = 'adm'
      $nova_wsgi_script_path        = '/usr/lib/cgi-bin/nova'
      $nova_api_wsgi_script_source  = '/usr/lib/python2.7/dist-packages/nova/wsgi/nova-api.py'
      # debian specific nova config
      $root_helper                  = 'sudo nova-rootwrap'
      $lock_path                    = '/var/lock/nova'
      $special_service_provider     = undef
      case $::os_package_type {
        'debian': {
          $spicehtml5proxy_package_name = 'nova-consoleproxy'
          $spicehtml5proxy_service_name = 'nova-spicehtml5proxy'
          $vncproxy_package_name    = 'nova-consoleproxy'
          $libvirt_service_name         = 'libvirtd'
        }
        default: {
          $spicehtml5proxy_package_name = 'nova-spiceproxy'
          $spicehtml5proxy_service_name = 'nova-spiceproxy'
          $vncproxy_package_name    = 'nova-novncproxy'
          $libvirt_service_name         = 'libvirt-bin'
        }
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }

}
