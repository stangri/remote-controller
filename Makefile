include $(TOPDIR)/rules.mk

PKG_NAME:=remote-controller
PKG_RELEASE:=1
PKG_LICENSE:=BSD-2-Clause

include $(INCLUDE_DIR)/package.mk

define Package/remote-controller
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Remote controller for provisioning agents (OpenWrt)
  DEPENDS:=+uhttpd +uhttpd-mod-ubus +libubox +jsonfilter +curl +coreutils-base64
endef

define Package/remote-controller/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,remote-controller))
