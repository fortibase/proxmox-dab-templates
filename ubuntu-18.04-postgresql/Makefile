UBUNTUVERSION:=bionic
BASEDIR:=$(shell dab basedir)

all: info/init_ok
	chmod -R +x ../scripts

	dab bootstrap

	../scripts/base.sh
	../scripts/change-timezone.sh
	../scripts/create-firstboot-service.sh
	../scripts/create-locales.sh
	../scripts/disable-password-authentication.sh
	../scripts/disable-root-login.sh
	../scripts/enable-firewall-http.sh
	../scripts/enable-firewall.sh
	../scripts/unattended-upgrades.sh
	../scripts/install-postgresql.sh 9.6
	../scripts/install-postgresql-extensions.sh  

	dab finalize

info/init_ok: dab.conf
	dab init
	touch $@

.PHONY: clean
clean:
	dab clean
	rm -f *~

.PHONY: dist-clean
dist-clean:
	dab dist-clean
	rm -f *~