#
# Copyright (C) 2006-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/Generic
  NAME:=Generic
  PACKAGES:= \
	kmod-3c59x kmod-8139too kmod-e100 kmod-e1000 kmod-natsemi \
	kmod-ne2k-pci kmod-pcnet32 kmod-r8169 kmod-sis900 kmod-sky2 \
	kmod-tg3 kmod-via-rhine
endef

define Profile/Generic/Description
	Generic Profile
endef
$(eval $(call Profile,Generic))
