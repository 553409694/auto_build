SRC_NAME = nginx-1.21.3
SRC_URL = http://nginx.org/download/$(SRC_NAME).tar.gz
PCRE_VERSION = 8.45
PCRE_NAME = pcre-$(PCRE_VERSION)
#PCRE_URL = ftp://ftp.pcre.org/pub/pcre/$(PCRE_NAME).tar.gz
PCRE_URL = https://sourceforge.net/projects/pcre/files/pcre/$(PCRE_VERSION)/$(PCRE_NAME).tar.gz/download
ZLIB_NAME = zlib-1.2.11
ZLIB_URL = http://www.zlib.net/$(ZLIB_NAME).tar.gz
THISDIR = $(shell pwd)

all: download_test extract_test config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)

download_test:
	( if [ ! -f $(SRC_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).tar.gz $(SRC_URL); \
	fi )
	( if [ ! -f $(PCRE_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(PCRE_NAME).tar.gz $(PCRE_URL); \
	fi )
	( if [ ! -f $(ZLIB_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(ZLIB_NAME).tar.gz $(ZLIB_URL); \
	fi )

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		tar xf $(SRC_NAME).tar.gz; \
#		patch -d $(SRC_NAME) -p1 -i ../nginx_for_padavan.patch; \
		for i in patch/*.*; do \
			patch -d $(SRC_NAME) -p1 -i ../$$i; \
		done \
	fi )
	( if [ ! -d $(PCRE_NAME) ]; then \
		tar xf $(PCRE_NAME).tar.gz; \
	fi )
	( if [ ! -d $(ZLIB_NAME) ]; then \
		tar xf $(ZLIB_NAME).tar.gz; \
	fi )

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

configure:
	( cd $(SRC_NAME) ; \
	./configure \
		--prefix=/usr/nginx \
		--with-http_ssl_module \
		--with-pcre="$(THISDIR)/$(PCRE_NAME)" \
		--with-zlib="$(THISDIR)/$(ZLIB_NAME)" \
		--with-http_v2_module \
		--with-http_sub_module \
                --with-stream \
                --with-stream_ssl_module \
                --with-stream_ssl_preread_module \
	)

clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) clean ; \
	fi ; \
	if [ -f $(PCRE_NAME)/Makefile ] ; then \
		$(MAKE) -C $(PCRE_NAME) distclean ; \
	fi ; \
	if [ -f $(ZLIB_NAME)/Makefile ] ; then \
		$(MAKE) -C $(ZLIB_NAME) distclean ; \
	fi ; \
	rm -f config_done

romfs:
	$(MAKE) -C $(SRC_NAME) DESTDIR=$(ROMFSDIR) install
#	$(SSTRIP_TOOL) $(ROMFSDIR)/usr/nginx/sbin/nginx
#	$(MAKE) -C $(SRC_NAME) install
#	$(MAKE) -C $(SRC_NAME) CONFIG_PREFIX=$(ROMFSDIR) install
#	$(ROMFSINST) -p +x $(THISDIR)/$(SRC_NAME)/socat /usr/bin/socat
