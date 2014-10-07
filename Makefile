PKG_NAME=mira-scitos
VERSION=0.1
MIRADIR=$(PKG_NAME)-$(VERSION)
ARCH=amd64

INSTALL_PREFIX=opt
INSTALL_ROOT=$(INSTALL_PREFIX)/$(PKG_NAME)

DEBPKG=$(PKG_NAME)_$(VERSION)-1_$(ARCH).deb


all:	$(DEBPKG)

clean:
	rm -rf $(MIRADIR) $(PKG_NAME)_$(VERSION).orig.tar.gz

apt:
	apt-get install debhelper libboost-all-dev libncurses5-dev libogre-dev libqwt5-qt4-dev libsqlite3-dev libssl-dev libxml2-dev libxrandr-dev pyqt4-dev-tools qt4-dev-tools ros-hydro-opencv2 subversion libsvn-dev

$(MIRADIR)/$(INSTALL_PREFIX):
	mkdir -p $(MIRADIR)/$(INSTALL_PREFIX)

dh_make: $(PKG_NAME)_$(VERSION).orig.tar.gz
	touch $@

$(PKG_NAME)_$(VERSION).orig.tar.gz: $(MIRADIR)/$(INSTALL_ROOT)
	(cd $(MIRADIR) && dh_make -c gpl3 -e marc@hanheide.net --createorig -s )

$(MIRADIR)/$(INSTALL_ROOT): $(MIRADIR)/$(INSTALL_PREFIX) /$(INSTALL_ROOT)/
	rsync -a /$(INSTALL_ROOT)/ $(MIRADIR)/$(INSTALL_ROOT)
	touch $(MIRADIR)/$(INSTALL_ROOT)

$(DEBPKG): patch
	(cd $(MIRADIR); dpkg-buildpackage -uc -us -b)
	
$(MIRADIR)/debian/$(PKG_NAME).dirs:
	echo "/$(INSTALL_ROOT)" > $@

patch:	dh_make $(MIRADIR)/debian/$(PKG_NAME).dirs
	patch -N $(MIRADIR)/debian/rules < patches/rules.patch
	patch -N $(MIRADIR)/debian/control < patches/control.patch
	touch $@



/$(INSTALL_ROOT):
	bash ./mira-installer-binary.sh ubuntu-1204lts-x64 /$(INSTALL_ROOT)
