### some further constants
LOCAL_PKG_DIR=$(PKG_NAME)-$(VERSION)
INSTALL_ROOT=$(INSTALL_PREFIX)/$(PKG_NAME)
DEBPKG=$(PKG_NAME)_$(VERSION)-1_$(ARCH).deb
COOKIES_DIR=cookies

# Targets shortcuts used in the rules below
LOCAL_PREFIX=$(LOCAL_PKG_DIR)/$(INSTALL_PREFIX)
LOCAL_ROOT=$(LOCAL_PKG_DIR)/$(INSTALL_ROOT)
PKG_DIRS_FILE=$(LOCAL_PKG_DIR)/debian/$(PKG_NAME).dirs
GLOBAL_ROOT=/$(INSTALL_ROOT)
ORIG_TAR_GZ=$(PKG_NAME)_$(VERSION).orig.tar.gz

# hack for substituting spaces into commas for the dependency list 
comma:= ,
empty:=
space:= $(empty) $(empty)
DEPENDS=$(subst $(space),$(comma),$(strip $(APT_INSTALL)))

all:	$(DEBPKG)

apt: 	$(COOKIES_DIR)/apt

patch:	$(COOKIES_DIR)/patch

clean:
	rm -rf $(LOCAL_PKG_DIR) $(ORIG_TAR_GZ) $(COOKIES_DIR) patches




$(COOKIES_DIR):
	mkdir -p $(COOKIES_DIR)

$(GLOBAL_ROOT):
	$(INSTALL_COMMAND)

$(COOKIES_DIR)/apt: $(COOKIES_DIR)
	apt-get install $(APT_INSTALL)
	touch $@

$(LOCAL_PREFIX):
	mkdir -p $(LOCAL_PKG_DIR)/$(INSTALL_PREFIX)

$(COOKIES_DIR)/dh_make: $(ORIG_TAR_GZ) $(COOKIES_DIR)
	touch $@

$(ORIG_TAR_GZ): $(LOCAL_ROOT)
	(cd $(LOCAL_PKG_DIR) && dh_make -c $(LICENSE) -e $(MAINTAINER) --createorig -s )

$(LOCAL_ROOT): $(LOCAL_PKG_DIR)/$(INSTALL_PREFIX) $(GLOBAL_ROOT)
	rsync -a $(GLOBAL_ROOT)/ $(LOCAL_ROOT)
	touch $@

$(DEBPKG): $(COOKIES_DIR)/patch
	(cd $(LOCAL_PKG_DIR); dpkg-buildpackage -uc -us -b)
	
$(PKG_DIRS_FILE):
	echo "$(GLOBAL_ROOT)" > $@


patches/%.patch: %.patch.template 
	@mkdir -p patches
	sed "s/@PKG_NAME@/$(PKG_NAME)/g" $<  |  sed "s/@DEPENDS@/$(DEPENDS)/g" >$@
	

$(COOKIES_DIR)/patch:	$(COOKIES_DIR)/dh_make $(PKG_DIRS_FILE) patches/rules.patch patches/control.patch $(COOKIES_DIR)
	patch -N $(LOCAL_PKG_DIR)/debian/rules < patches/rules.patch
	patch -N $(LOCAL_PKG_DIR)/debian/control < patches/control.patch
	touch $@

