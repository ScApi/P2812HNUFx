#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

USB_MENU:=USB Support

USBNET_DIR:=net/usb
USBHID_DIR?=hid/usbhid
USBINPUT_DIR?=input/misc

define KernelPackage/usb-core
  SUBMENU:=$(USB_MENU)
  TITLE:=Support for USB
  DEPENDS:=@USB_SUPPORT +kmod-nls-base
  KCONFIG:=CONFIG_USB
  FILES:=$(LINUX_DIR)/drivers/usb/core/usbcore.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,20,usbcore,1)
endef

define KernelPackage/usb-core/description
 Kernel support for USB
endef

$(eval $(call KernelPackage,usb-core))


define AddDepends/usb
  SUBMENU:=$(USB_MENU)
  DEPENDS+=+!TARGET_etrax:kmod-usb-core $(1)
endef


define KernelPackage/usb-uhci
  TITLE:=Support for UHCI controllers
  KCONFIG:= \
	CONFIG_USB_UHCI_ALT \
	CONFIG_USB_UHCI_HCD
  FILES:=$(LINUX_DIR)/drivers/usb/host/uhci-hcd.ko
  AUTOLOAD:=$(call AutoLoad,50,uhci-hcd,1)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-uhci/description
 Kernel support for USB UHCI controllers
endef

$(eval $(call KernelPackage,usb-uhci,1))


define KernelPackage/usb-ohci
  TITLE:=Support for OHCI controllers
  KCONFIG:= \
	CONFIG_USB_OHCI \
	CONFIG_USB_OHCI_HCD \
	CONFIG_USB_OHCI_AR71XX=y
  FILES:=$(LINUX_DIR)/drivers/usb/host/ohci-hcd.ko
  AUTOLOAD:=$(call AutoLoad,50,ohci-hcd,1)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-ohci/description
 Kernel support for USB OHCI controllers
endef

$(eval $(call KernelPackage,usb-ohci,1))


define KernelPackage/usb-isp116x-hcd
  TITLE:=Support for the ISP116x USB Host Controller
  DEPENDS:=@TARGET_ppc40x
  KCONFIG:= \
	CONFIG_USB_ISP116X_HCD \
	CONFIG_USB_ISP116X_HCD_OF=y \
	CONFIG_USB_ISP116X_HCD_PLATFORM=n
  FILES:=$(LINUX_DIR)/drivers/usb/host/isp116x-hcd.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,50,isp116x-hcd)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-isp116x-hcd/description
  Kernel support for the ISP116X USB Host Controller
endef

$(eval $(call KernelPackage,usb-isp116x-hcd))


define KernelPackage/usb2
  TITLE:=Support for USB2 controllers
  KCONFIG:=CONFIG_USB_EHCI_HCD \
    CONFIG_USB_EHCI_AR71XX=y
  FILES:=$(LINUX_DIR)/drivers/usb/host/ehci-hcd.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,40,ehci-hcd,1)
  $(call AddDepends/usb)
endef

define KernelPackage/usb2/description
 Kernel support for USB2 (EHCI) controllers
endef

$(eval $(call KernelPackage,usb2))


define KernelPackage/usb-acm
  TITLE:=Support for modems/isdn controllers
  KCONFIG:=CONFIG_USB_ACM
  FILES:=$(LINUX_DIR)/drivers/usb/class/cdc-acm.ko
  AUTOLOAD:=$(call AutoLoad,60,cdc-acm)
$(call AddDepends/usb)
endef

define KernelPackage/usb-acm/description
 Kernel support for USB ACM devices (modems/isdn controllers)
endef

$(eval $(call KernelPackage,usb-acm))


define KernelPackage/usb-audio
  TITLE:=Support for USB audio devices
  KCONFIG:= \
	CONFIG_USB_AUDIO \
	CONFIG_SND_USB_AUDIO
  $(call AddDepends/usb)
  $(call AddDepends/sound)
ifeq ($(strip $(call CompareKernelPatchVer,$(KERNEL_PATCHVER),ge,2.6.35)),1)
  FILES:= \
	$(LINUX_DIR)/sound/usb/snd-usbmidi-lib.ko \
	$(LINUX_DIR)/sound/usb/snd-usb-audio.ko
  AUTOLOAD:=$(call AutoLoad,60,snd-usbmidi-lib snd-usb-audio)
else
  FILES:= \
	$(LINUX_DIR)/sound/usb/snd-usb-lib.ko \
	$(LINUX_DIR)/sound/usb/snd-usb-audio.ko
  AUTOLOAD:=$(call AutoLoad,60,snd-usb-lib snd-usb-audio)
endif
endef

define KernelPackage/usb-audio/description
 Kernel support for USB audio devices
endef

$(eval $(call KernelPackage,usb-audio))


define KernelPackage/usb-printer
  TITLE:=Support for printers
  KCONFIG:=CONFIG_USB_PRINTER
  FILES:=$(LINUX_DIR)/drivers/usb/class/usblp.ko
  AUTOLOAD:=$(call AutoLoad,60,usblp)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-printer/description
 Kernel support for USB printers
endef

$(eval $(call KernelPackage,usb-printer))


define KernelPackage/usb-serial
  TITLE:=Support for USB-to-Serial converters
  KCONFIG:=CONFIG_USB_SERIAL
  FILES:=$(LINUX_DIR)/drivers/usb/serial/usbserial.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,60,usbserial)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-serial/description
 Kernel support for USB-to-Serial converters
endef

$(eval $(call KernelPackage,usb-serial))


define AddDepends/usb-serial
  SUBMENU:=$(USB_MENU)
  DEPENDS+=kmod-usb-serial $(1)
endef


define KernelPackage/usb-serial-airprime
  TITLE:=Support for Airprime (EVDO)
  KCONFIG:=CONFIG_USB_SERIAL_AIRPRIME
  FILES:=$(LINUX_DIR)/drivers/usb/serial/airprime.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,airprime)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-airprime/description
 Kernel support for Airprime (EVDO)
endef

$(eval $(call KernelPackage,usb-serial-airprime))


define KernelPackage/usb-serial-belkin
  TITLE:=Support for Belkin devices
  KCONFIG:=CONFIG_USB_SERIAL_BELKIN
  FILES:=$(LINUX_DIR)/drivers/usb/serial/belkin_sa.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,belkin_sa)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-belkin/description
 Kernel support for Belkin USB-to-Serial converters
endef

$(eval $(call KernelPackage,usb-serial-belkin))


define KernelPackage/usb-serial-ch341
  TITLE:=Support for CH341 devices
  KCONFIG:=CONFIG_USB_SERIAL_CH341
  FILES:=$(LINUX_DIR)/drivers/usb/serial/ch341.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,ch341)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-belkin/description
 Kernel support for Winchiphead CH341 USB-to-Serial converters
endef

$(eval $(call KernelPackage,usb-serial-ch341))


define KernelPackage/usb-serial-ftdi
  TITLE:=Support for FTDI devices
  KCONFIG:=CONFIG_USB_SERIAL_FTDI_SIO
  FILES:=$(LINUX_DIR)/drivers/usb/serial/ftdi_sio.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,ftdi_sio)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-ftdi/description
 Kernel support for FTDI USB-to-Serial converters
endef

$(eval $(call KernelPackage,usb-serial-ftdi))


define KernelPackage/usb-serial-mct
  TITLE:=Support for Magic Control Tech. devices
  KCONFIG:=CONFIG_USB_SERIAL_MCT_U232
  FILES:=$(LINUX_DIR)/drivers/usb/serial/mct_u232.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,mct_u232)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-mct/description
 Kernel support for Magic Control Technology USB-to-Serial converters
endef

$(eval $(call KernelPackage,usb-serial-mct))


define KernelPackage/usb-serial-pl2303
  TITLE:=Support for Prolific PL2303 devices
  KCONFIG:=CONFIG_USB_SERIAL_PL2303
  FILES:=$(LINUX_DIR)/drivers/usb/serial/pl2303.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,pl2303)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-pl2303/description
 Kernel support for Prolific PL2303 USB-to-Serial converters
endef

$(eval $(call KernelPackage,usb-serial-pl2303))


define KernelPackage/usb-serial-cp210x
  TITLE:=Support for Silicon Labs cp210x devices
  KCONFIG:=CONFIG_USB_SERIAL_CP210X
  FILES:=$(LINUX_DIR)/drivers/usb/serial/cp210x.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,cp210x)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-cp210x/description
 Kernel support for Silicon Labs cp210x USB-to-Serial converters
endef

$(eval $(call KernelPackage,usb-serial-cp210x))


define KernelPackage/usb-serial-ark3116
  TITLE:=Support for ArkMicroChips ARK3116 devices
  KCONFIG:=CONFIG_USB_SERIAL_ARK3116
  FILES:=$(LINUX_DIR)/drivers/usb/serial/ark3116.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,ark3116)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-ark3116/description
 Kernel support for ArkMicroChips ARK3116 USB-to-Serial converters
endef

$(eval $(call KernelPackage,usb-serial-ark3116))


define KernelPackage/usb-serial-oti6858
  TITLE:=Support for Ours Technology OTI6858 devices
  KCONFIG:=CONFIG_USB_SERIAL_OTI6858
  FILES:=$(LINUX_DIR)/drivers/usb/serial/oti6858.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,oti6858)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-oti6858/description
 Kernel support for Ours Technology OTI6858 USB-to-Serial converters
endef

$(eval $(call KernelPackage,usb-serial-oti6858))


define KernelPackage/usb-serial-sierrawireless
  TITLE:=Support for Sierra Wireless devices
  KCONFIG:=CONFIG_USB_SERIAL_SIERRAWIRELESS
  FILES:=$(LINUX_DIR)/drivers/usb/serial/sierra.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,sierra)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-sierrawireless/description
 Kernel support for Sierra Wireless devices
endef

$(eval $(call KernelPackage,usb-serial-sierrawireless))


define KernelPackage/usb-serial-motorola-phone
  TITLE:=Support for Motorola usb phone
  KCONFIG:=CONFIG_USB_SERIAL_MOTOROLA
  FILES:=$(LINUX_DIR)/drivers/usb/serial/moto_modem.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,moto_modem)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-motorola-phone/description
 Kernel support for Motorola usb phone
endef

$(eval $(call KernelPackage,usb-serial-motorola-phone))


define KernelPackage/usb-serial-visor
  TITLE:=Support for Handspring Visor devices
  KCONFIG:=CONFIG_USB_SERIAL_VISOR
  FILES:=$(LINUX_DIR)/drivers/usb/serial/visor.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,visor)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-visor/description
 Kernel support for Handspring Visor PDAs
endef

$(eval $(call KernelPackage,usb-serial-visor))


define KernelPackage/usb-serial-cypress-m8
  TITLE:=Support for CypressM8 USB-Serial
  KCONFIG:=CONFIG_USB_SERIAL_CYPRESS_M8
  FILES:=$(LINUX_DIR)/drivers/usb/serial/cypress_m8.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,cypress_m8)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-cypress-m8/description
 Kernel support for devices with Cypress M8 USB to Serial chip
 (for example, the Delorme Earthmate LT-20 GPS)
 Supported microcontrollers in the CY4601 family are:
       CY7C63741 CY7C63742 CY7C63743 CY7C64013
endef

$(eval $(call KernelPackage,usb-serial-cypress-m8))


define KernelPackage/usb-serial-keyspan
  TITLE:=Support for Keyspan USB-to-Serial devices
  KCONFIG:= \
	CONFIG_USB_SERIAL_KEYSPAN \
	CONFIG_USB_SERIAL_KEYSPAN_USA28 \
	CONFIG_USB_SERIAL_KEYSPAN_USA28X \
	CONFIG_USB_SERIAL_KEYSPAN_USA28XA \
	CONFIG_USB_SERIAL_KEYSPAN_USA28XB \
	CONFIG_USB_SERIAL_KEYSPAN_USA19 \
	CONFIG_USB_SERIAL_KEYSPAN_USA18X \
	CONFIG_USB_SERIAL_KEYSPAN_USA19W \
	CONFIG_USB_SERIAL_KEYSPAN_USA19QW \
	CONFIG_USB_SERIAL_KEYSPAN_USA19QI \
	CONFIG_USB_SERIAL_KEYSPAN_MPR \
	CONFIG_USB_SERIAL_KEYSPAN_USA49W \
	CONFIG_USB_SERIAL_KEYSPAN_USA49WLC
  FILES:=$(LINUX_DIR)/drivers/usb/serial/keyspan.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,keyspan)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-keyspan/description
 Kernel support for Keyspan USB-to-Serial devices
endef

$(eval $(call KernelPackage,usb-serial-keyspan))


define KernelPackage/usb-serial-option
  TITLE:=Support for Option HSDPA modems
  KCONFIG:=CONFIG_USB_SERIAL_OPTION
  FILES:=$(LINUX_DIR)/drivers/usb/serial/option.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,65,option)
  $(call AddDepends/usb-serial)
endef

define KernelPackage/usb-serial-option/description
 Kernel support for Option HSDPA modems
endef

$(eval $(call KernelPackage,usb-serial-option))


define KernelPackage/usb-storage
  TITLE:=USB Storage support
  DEPENDS:= +!TARGET_x86:kmod-scsi-core
  KCONFIG:=CONFIG_USB_STORAGE
  FILES:=$(LINUX_DIR)/drivers/usb/storage/usb-storage.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,60,usb-storage,1)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-storage/description
 Kernel support for USB Mass Storage devices
endef

$(eval $(call KernelPackage,usb-storage))


define KernelPackage/usb-storage-extras
  SUBMENU:=$(USB_MENU)
  TITLE:=Extra drivers for usb-storage
  DEPENDS:=+kmod-usb-storage
  KCONFIG:= \
	CONFIG_USB_STORAGE_ALAUDA \
	CONFIG_USB_STORAGE_CYPRESS_ATACB \
	CONFIG_USB_STORAGE_DATAFAB \
	CONFIG_USB_STORAGE_FREECOM \
	CONFIG_USB_STORAGE_ISD200 \
	CONFIG_USB_STORAGE_JUMPSHOT \
	CONFIG_USB_STORAGE_KARMA \
	CONFIG_USB_STORAGE_SDDR09 \
	CONFIG_USB_STORAGE_SDDR55 \
	CONFIG_USB_STORAGE_USBAT
  FILES:= \
	$(LINUX_DIR)/drivers/usb/storage/ums-alauda.$(LINUX_KMOD_SUFFIX) \
	$(LINUX_DIR)/drivers/usb/storage/ums-cypress.$(LINUX_KMOD_SUFFIX) \
	$(LINUX_DIR)/drivers/usb/storage/ums-datafab.$(LINUX_KMOD_SUFFIX) \
	$(LINUX_DIR)/drivers/usb/storage/ums-freecom.$(LINUX_KMOD_SUFFIX) \
	$(LINUX_DIR)/drivers/usb/storage/ums-isd200.$(LINUX_KMOD_SUFFIX) \
	$(LINUX_DIR)/drivers/usb/storage/ums-jumpshot.$(LINUX_KMOD_SUFFIX) \
	$(LINUX_DIR)/drivers/usb/storage/ums-karma.$(LINUX_KMOD_SUFFIX) \
	$(LINUX_DIR)/drivers/usb/storage/ums-sddr09.$(LINUX_KMOD_SUFFIX) \
	$(LINUX_DIR)/drivers/usb/storage/ums-sddr55.$(LINUX_KMOD_SUFFIX) \
	$(LINUX_DIR)/drivers/usb/storage/ums-usbat.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,60,ums-alauda ums-cypress ums-datafab \
				ums-freecom ums-isd200 ums-jumpshot \
				ums-karma ums-sddr09 ums-sddr55 ums-usbat)
endef

define KernelPackage/usb-storage-extras/description
  Say Y here if you want to have some more drivers,
  such as for SmartMedia card readers.
endef

$(eval $(call KernelPackage,usb-storage-extras))


define KernelPackage/usb-video
  TITLE:=Support for USB video devices
  KCONFIG:=CONFIG_VIDEO_USBVIDEO
  FILES:=$(LINUX_DIR)/drivers/media/video/usbvideo/usbvideo.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,61,usbvideo)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-video/description
 Kernel support for USB video devices
endef

$(eval $(call KernelPackage,usb-video))


define KernelPackage/usb-atm
  TITLE:=Support for ATM on USB bus
  DEPENDS:=+kmod-atm
  KCONFIG:=CONFIG_USB_ATM
  FILES:=$(LINUX_DIR)/drivers/usb/atm/usbatm.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,60,usbatm)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-atm/description
 Kernel support for USB DSL modems
endef

$(eval $(call KernelPackage,usb-atm))


define AddDepends/usb-atm
  SUBMENU:=$(USB_MENU)
  DEPENDS+=kmod-usb-atm $(1)
endef


define KernelPackage/usb-atm-speedtouch
  TITLE:=SpeedTouch USB ADSL modems support
  KCONFIG:=CONFIG_USB_SPEEDTOUCH
  FILES:=$(LINUX_DIR)/drivers/usb/atm/speedtch.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,70,speedtch)
  $(call AddDepends/usb-atm)
endef

define KernelPackage/usb-atm-speedtouch/description
 Kernel support for SpeedTouch USB ADSL modems
endef

$(eval $(call KernelPackage,usb-atm-speedtouch))


define KernelPackage/usb-atm-ueagle
  TITLE:=Eagle 8051 based USB ADSL modems support
  FILES:=$(LINUX_DIR)/drivers/usb/atm/ueagle-atm.$(LINUX_KMOD_SUFFIX)
  KCONFIG:=CONFIG_USB_UEAGLEATM
  AUTOLOAD:=$(call AutoLoad,70,ueagle-atm)
  $(call AddDepends/usb-atm)
endef

define KernelPackage/usb-atm-ueagle/description
 Kernel support for Eagle 8051 based USB ADSL modems
endef

$(eval $(call KernelPackage,usb-atm-ueagle))


define KernelPackage/usb-atm-cxacru
  TITLE:=cxacru
  FILES:=$(LINUX_DIR)/drivers/usb/atm/cxacru.$(LINUX_KMOD_SUFFIX)
  KCONFIG:=CONFIG_USB_CXACRU
  AUTOLOAD:=$(call AutoLoad,70,cxacru)
  $(call AddDepends/usb-atm)
endef

define KernelPackage/usb-atm-cxacru/description
 Kernel support for cxacru based USB ADSL modems
endef

$(eval $(call KernelPackage,usb-atm-cxacru))


define KernelPackage/usb-net
  TITLE:=Kernel modules for USB-to-Ethernet convertors
  KCONFIG:=CONFIG_USB_USBNET
  AUTOLOAD:=$(call AutoLoad,60,usbnet)
  FILES:=$(LINUX_DIR)/drivers/$(USBNET_DIR)/usbnet.$(LINUX_KMOD_SUFFIX)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-net/description
 Kernel modules for USB-to-Ethernet convertors
endef

$(eval $(call KernelPackage,usb-net))


define AddDepends/usb-net
  SUBMENU:=$(USB_MENU)
  DEPENDS+=kmod-usb-net $(1)
endef


define KernelPackage/usb-net-asix
  TITLE:=Kernel module for USB-to-Ethernet Asix convertors
  KCONFIG:=CONFIG_USB_NET_AX8817X
  FILES:=$(LINUX_DIR)/drivers/$(USBNET_DIR)/asix.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,61,asix)
  $(call AddDepends/usb-net)
endef

define KernelPackage/usb-net-asix/description
 Kernel module for USB-to-Ethernet Asix convertors
endef

$(eval $(call KernelPackage,usb-net-asix))


define KernelPackage/usb-net-hso
  TITLE:=Kernel module for Option USB High Speed Mobile Devices
  KCONFIG:=CONFIG_USB_HSO
  FILES:= \
	$(LINUX_DIR)/drivers/$(USBNET_DIR)/hso.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,61,hso)
  $(call AddDepends/usb-net)
  $(call AddDepends/rfkill)
endef

define KernelPackage/usb-net-hso/description
 Kernel module for Option USB High Speed Mobile Devices
endef

$(eval $(call KernelPackage,usb-net-hso))


define KernelPackage/usb-net-kaweth
  TITLE:=Kernel module for USB-to-Ethernet Kaweth convertors
  KCONFIG:=CONFIG_USB_KAWETH
  FILES:=$(LINUX_DIR)/drivers/$(USBNET_DIR)/kaweth.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,61,kaweth)
  $(call AddDepends/usb-net)
endef

define KernelPackage/usb-net-kaweth/description
 Kernel module for USB-to-Ethernet Kaweth convertors
endef

$(eval $(call KernelPackage,usb-net-kaweth))


define KernelPackage/usb-net-pegasus
  TITLE:=Kernel module for USB-to-Ethernet Pegasus convertors
  KCONFIG:=CONFIG_USB_PEGASUS
  FILES:=$(LINUX_DIR)/drivers/$(USBNET_DIR)/pegasus.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,61,pegasus)
  $(call AddDepends/usb-net)
endef

define KernelPackage/usb-net-pegasus/description
 Kernel module for USB-to-Ethernet Pegasus convertors
endef

$(eval $(call KernelPackage,usb-net-pegasus))


define KernelPackage/usb-net-mcs7830
  TITLE:=Kernel module for USB-to-Ethernet MCS7830 convertors
  KCONFIG:=CONFIG_USB_NET_MCS7830
  FILES:=$(LINUX_DIR)/drivers/$(USBNET_DIR)/mcs7830.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,61,mcs7830)
  $(call AddDepends/usb-net)
endef

define KernelPackage/usb-net-mcs7830/description
 Kernel module for USB-to-Ethernet MCS7830 convertors
endef

$(eval $(call KernelPackage,usb-net-mcs7830))


define KernelPackage/usb-net-dm9601-ether
  TITLE:=Support for DM9601 ethernet connections
  KCONFIG:=CONFIG_USB_NET_DM9601
  FILES:=$(LINUX_DIR)/drivers/$(USBNET_DIR)/dm9601.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,61,dm9601)
  $(call AddDepends/usb-net)
endef

define KernelPackage/usb-net-dm9601-ether/description
  Kernel support for USB DM9601 devices
endef

$(eval $(call KernelPackage,usb-net-dm9601-ether))

define KernelPackage/usb-net-cdc-ether
  TITLE:=Support for cdc ethernet connections
  KCONFIG:=CONFIG_USB_NET_CDCETHER
  FILES:=$(LINUX_DIR)/drivers/$(USBNET_DIR)/cdc_ether.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,61,cdc_ether)
  $(call AddDepends/usb-net)
endef

define KernelPackage/usb-net-cdc-ether/description
 Kernel support for USB CDC Ethernet devices
endef

$(eval $(call KernelPackage,usb-net-cdc-ether))


define KernelPackage/usb-net-rndis
  TITLE:=Support for RNDIS connections
  KCONFIG:=CONFIG_USB_NET_RNDIS_HOST
  FILES:= $(LINUX_DIR)/drivers/$(USBNET_DIR)/rndis_host.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,62,rndis_host)
  $(call AddDepends/usb-net,+kmod-usb-net-cdc-ether)
endef

define KernelPackage/usb-net-rndis/description
 Kernel support for RNDIS connections
endef

$(eval $(call KernelPackage,usb-net-rndis))


define KernelPackage/usb-hid
  TITLE:=Support for USB Human Input Devices
  KCONFIG:=CONFIG_HID_SUPPORT=y CONFIG_USB_HID
  FILES:=$(LINUX_DIR)/drivers/$(USBHID_DIR)/usbhid.ko
  AUTOLOAD:=$(call AutoLoad,70,usbhid)
  $(call AddDepends/usb)
  $(call AddDepends/hid)
  $(call AddDepends/input,+kmod-input-evdev)
endef


define KernelPackage/usb-hid/description
 Kernel support for USB HID devices such as keyboards and mice
endef

$(eval $(call KernelPackage,usb-hid))


define KernelPackage/usb-yealink
  TITLE:=USB Yealink VOIP phone
  KCONFIG:=CONFIG_USB_YEALINK CONFIG_INPUT_YEALINK CONFIG_INPUT=m CONFIG_INPUT_MISC=y
  FILES:=$(LINUX_DIR)/drivers/$(USBINPUT_DIR)/yealink.ko
  AUTOLOAD:=$(call AutoLoad,70,yealink)
  $(call AddDepends/usb)
  $(call AddDepends/input,+kmod-input-evdev)
endef

define KernelPackage/usb-yealink/description
 Kernel support for Yealink VOIP phone
endef

$(eval $(call KernelPackage,usb-yealink))


define KernelPackage/usb-cm109
  TITLE:=Support for CM109 device
  KCONFIG:=CONFIG_USB_CM109 CONFIG_INPUT_CM109 CONFIG_INPUT=m CONFIG_INPUT_MISC=y
  FILES:=$(LINUX_DIR)/drivers/$(USBINPUT_DIR)/cm109.ko
  AUTOLOAD:=$(call AutoLoad,70,cm109)
  $(call AddDepends/usb)
  $(call AddDepends/input,+kmod-input-evdev)
endef

define KernelPackage/usb-cm109/description
 Kernel support for CM109 VOIP phone
endef

$(eval $(call KernelPackage,usb-cm109))


define KernelPackage/usb-test
  TITLE:=USB Testing Driver
  DEPENDS:=@DEVEL
  KCONFIG:=CONFIG_USB_TEST
  FILES:=$(LINUX_DIR)/drivers/usb/misc/usbtest.ko
  $(call AddDepends/usb)
endef

define KernelPackage/usb-test/description
 Kernel support for testing USB Host Controller software.
endef

$(eval $(call KernelPackage,usb-test))


define KernelPackage/usb-phidget
  TITLE:=USB Phidget Driver
  KCONFIG:=CONFIG_USB_PHIDGET CONFIG_USB_PHIDGETKIT CONFIG_USB_PHIDGETMOTORCONTROL CONFIG_USB_PHIDGETSERVO
  FILES:=$(LINUX_DIR)/drivers/usb/misc/phidget*.ko
$(call AddDepends/usb)
endef

define KernelPackage/usb-phidget/description
 Kernel support for USB Phidget devices.
endef

$(eval $(call KernelPackage,usb-phidget))

