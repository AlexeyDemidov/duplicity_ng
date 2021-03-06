#
# Cookbook Name:: duplicity_ng
# Attributes:: default
#
# Copyright (C) 2014 Chris Aumann
# Copyright (C) 2014 Alexander Merkulov
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Path to duplicity executeable
default['duplicity_ng']['path'] = '/usr/bin/duplicity'

# Path where duplicity configuration (credential environment variables, etc) are stored
default['duplicity_ng']['confdir'] = value_for_platform_family(
  'debian' => '/etc/default',
  'rhel' => '/etc/sysconfig',
  'default' => '/etc',
)

# Set this to true to use pip to install duplicity dependencies
default['duplicity_ng']['use_pip'] = false

# Variables for installing duplicity from source
default['duplicity_ng']['source']['checksum'] = '11cbad44a90891af1bf9e294260ba7c21a1660ccd3ab2c6e736ba74ac5cf0fe6'
default['duplicity_ng']['source']['version'] = '0.7.12'
default['duplicity_ng']['source']['url'] = "https://launchpad.net/duplicity/0.7-series/#{node['duplicity_ng']['source']['version']}/+download/duplicity-#{node['duplicity_ng']['source']['version']}.tar.gz"

default['duplicity_ng']['source']['gnupg']['version'] = '0.3.2'
default['duplicity_ng']['source']['gnupg']['url'] = "http://downloads.sourceforge.net/project/py-gnupg/GnuPGInterface/#{node['duplicity_ng']['source']['gnupg']['version']}/GnuPGInterface-#{node['duplicity_ng']['source']['gnupg']['version']}.tar.gz"
default['duplicity_ng']['source']['gnupg']['checksum'] = '0ea672251e2e3f71b62fef0c01539519d500f6b338f803af6b57e67a73cca8e6'

default['duplicity_ng']['source']['azure']['package'] = 'azure-storage'
default['duplicity_ng']['source']['azure']['version'] = '0.34.2'
default['duplicity_ng']['source']['azure']['url'] = "https://github.com/Azure/azure-storage-python/archive/v#{node['duplicity_ng']['source']['azure']['version']}.tar.gz"
default['duplicity_ng']['source']['azure']['checksum'] = 'be427064cc7db99629c76703c2cf2bc5e0be9e926a0d2f291d19aaccd7a6243b'

case node['platform_family']
when 'debian'
  default['duplicity_ng']['source']['dev']['packages'] = %w(librsync-dev libssl-dev)
  default['duplicity_ng']['source']['azure']['packages'] = %w(libffi-dev)
  default['duplicity_ng']['source']['python']['packages'] = %w(python-lockfile python-setuptools python-gnupginterface)
  default['duplicity_ng']['source']['par2']['packages'] = %w(par2)
  default['duplicity_ng']['source']['pexpect']['packages'] = %w(python-pexpect)
when 'rhel', 'fedora', 'suse'
  # Use pip by default on rhel, as the packages are outdated
  default['duplicity_ng']['use_pip'] = true
  default['duplicity_ng']['source']['dev']['packages'] = %w(librsync-devel openssl-devel)
  default['duplicity_ng']['source']['azure']['packages'] = %w(libffi-devel)
  default['duplicity_ng']['source']['python']['packages'] = %w(python-lockfile python-setuptools python-GnuPGInterface)
  default['duplicity_ng']['source']['par2']['packages'] = %w(par2cmdline)
  default['duplicity_ng']['source']['pexpect']['packages'] = %w(pexpect)
end
