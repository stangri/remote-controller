# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright 2025-2026 MOSSDeF, Stan Grishin (stangri@melmac.ca).

include $(TOPDIR)/rules.mk

PKG_NAME:=remote-controller
PKG_VERSION:=0.0.1
PKG_RELEASE:=1
PKG_LICENSE:=AGPL-3.0-or-later
PKG_MAINTAINER:=Stan Grishin <stangri@melmac.ca>

include $(INCLUDE_DIR)/package.mk

define Package/remote-controller
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Remote controller for provisioning OpenWrt agents
  DEPENDS:=+uhttpd +uhttpd-mod-ubus +libubox +jsonfilter +curl +coreutils-base64
endef

define Package/remote-controller/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/remote-controller $(1)/etc/config/remote-controller
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/remote-controller $(1)/etc/init.d/remote-controller
	$(SED) "s|^\(readonly PKG_VERSION\).*|\1='$(PKG_VERSION)-r$(PKG_RELEASE)'|" $(1)/etc/init.d/remote-controller
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN)  ./files/etc/uci-defaults/99-remote-controller $(1)/etc/uci-defaults/99-remote-controller
	$(INSTALL_DIR) $(1)/www/cgi-bin/remote-controller
	$(INSTALL_BIN) ./files/www/cgi-bin/remote-controller/enroll $(1)/www/cgi-bin/remote-controller/enroll
	$(INSTALL_DIR) $(1)/www/remote-controller
	$(INSTALL_DATA) ./www/remote-controller/index.html $(1)/www/remote-controller/index.html
endef

$(eval $(call BuildPackage,remote-controller))
