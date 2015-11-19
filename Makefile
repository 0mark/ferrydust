PREFIX="/usr/local"
ETCPREFIX="/etc"
BINPREFIX="$PREFIX/bin"
SBINPREFIX="$PREFIX/sbin"
LIBPREFIX="$PREFIX/lib"
ACPIPREFIX="$ETCPREFIX/acpi"
UDEVPREFIX="$LIBPREFIX/udev"

install:
	@echo "installing scripts to ${BINPREFIX}"
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f fd-* ferrycharm ferrysparkle ferryrandr dmount dumount ${DESTDIR}${BINPREFIX}
	@sed "s#PREFIX#${PREFIX}#g" < powernow > ${DESTDIR}${BINPREFIX}/powernow

	@echo "installing scripts to ${SBINPREFIX}"
	@cp -f rdbks ${DESTDIR}${SBINPREFIX}
	@sed "s#ETCPREFIX#${ETCPREFIX}#g;s#PREFIX#${PREFIX}#g" < powerdown > ${DESTDIR}${SBINPREFIX}/powerdown
	@sed "s#ETCPREFIX#${ETCPREFIX}#g;s#PREFIX#${PREFIX}#g" < powerup > ${DESTDIR}${SBINPREFIX}/powerup
	@sed "s#ETCPREFIX#${ETCPREFIX}#g" < scripts/setbat > ${DESTDIR}${SBINPREFIX}/setbat
	@sed "s#ETCPREFIX#${ETCPREFIX}#g" < scripts/setbright > ${DESTDIR}${SBINPREFIX}/setbright
	@sed "s#ETCPREFIX#${ETCPREFIX}#g" < scripts/sitnol > ${DESTDIR}${SBINPREFIX}/sitnol
	@sed "s#ETCPREFIX#${ETCPREFIX}#g" < scripts/suspto > ${DESTDIR}${SBINPREFIX}/suspto
	@sed "s#ETCPREFIX#${ETCPREFIX}#g" < scripts/vmod > ${DESTDIR}${SBINPREFIX}/vmod

	@echo "installing libs to ${LIBPREFIX}"
	install -D powerdown-functions ${DESTDIR}${LIBPREFIX}/powerdown-functions

	@echo "installing events to ${ACPIPREFIX}/events_available"
	@mkdir -p ${DESTDIR}${ACPIPREFIX}/events_available
	@for i in $(ls acpi-events); do sed "s#PREFIX#${PREFIX}#g" < acpi-events/$$i > ${DESTDIR}${ACPIPREFIX}/events_available/$$i; done
	
	@echo "installing config to ${ETCPREFIX}"
	@cp -f acpithings.rc ${DESTDIR}${ETCPREFIX}/acpithings.rc
	install -D conf ${DESTDIR}${ETCPREFIX}/powerdown/conf

	@echo "installing udev rules to ${UDEVPREFIX}/rules.d"
	install -D powerdown.rules ${DESTDIR}${SYSPREFIX}/rules.d/99-powerdown.rules

.PHONY: install







	install -d ${DESTDIR}${ETCPREFIX}/powerdown/down

	install -d ${DESTDIR}${ETCPREFIX}/powerdown/up
