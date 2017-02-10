PREFIX="/usr/local"
ETCPREFIX="/etc"
BINPREFIX="${PREFIX}/bin"
SBINPREFIX="${PREFIX}/sbin"
LIBPREFIX="${PREFIX}/lib"
ACPIPREFIX="${ETCPREFIX}/acpi"
UDEVPREFIX="${LIBPREFIX}/udev"
SHAREPREFIX="${PREFIX}/share"
SHELL_FULL=/bin/sh
SHELL_SIMPLE=/bin/sh
MKINST=./inst.sh ${ETCPREFIX} ${SBINPREFIX} ${BINPREFIX} ${LIBPREFIX} ${ACPIPREFIX} ${UDEVPREFIX} ${SHAREPREFIX} ${PREFIX} ${SHELL_FULL} ${SHELL_SIMPLE}

install:
	@echo "installing scripts to ${BINPREFIX}"
	@mkdir -p ${DESTDIR}${BINPREFIX}
	@${MKINST} ./scripts ${DESTDIR}${BINPREFIX} 755 
	fd-app  fd-getkey fd-haskey fd-iftrue fd-mount fd-pm fd-ulock fd-unotify fd-urandr ferrycharm ferryglamour ferrysparkle

	@echo "installing scripts to ${SBINPREFIX}"
	@mkdir -p ${DESTDIR}${SBINPREFIX}
	@${MKINST} ./scripts ${DESTDIR}${SBINPREFIX} 755 fd-backup fd-lowbat fd-smapi-bat fd-bright-ctrl fd-suspend fd-tablet

	@echo "installing libs to ${LIBPREFIX}"
	@mkdir -p ${DESTDIR}${LIBPREFIX}
	@${MKINST} ./libs ${DESTDIR}${LIBPREFIX} 755 fd-functions fd-pm-functions

	@echo "installing events to ${ACPIPREFIX}/events_available"
	@mkdir -p ${DESTDIR}${ACPIPREFIX}/events_available
	@${MKINST} ./acpi-events ${DESTDIR}${ACPIPREFIX}/events_available 644 ac_adapter_AC anything battery_BATX battery_CPUX battery_PNPX button_BAT button_LID_close button_LID_open button_MUTE button_PBTN button_PROGX button_SCRNLCK button_SLPB button_SUSP button_VOLDN button_VOLUP button_WLAN button_ZOOM video_BRTDN video_BRTUP video_TBLT video_VMOD

	@echo "installing config to ${ETCPREFIX}"
	@mkdir -p ${DESTDIR}${ETCPREFIX}/ferrydust/pm.d
	@cp -f config/pm.rc ${DESTDIR}${ETCPREFIX}/ferrydust/pm.rc
	@cp -f config/system.rc ${DESTDIR}${ETCPREFIX}/ferrydust/system.rc

	@echo "installing config examples to ${SHAREPREFIX}"
	@mkdir -p ${DESTDIR}${SHAREPREFIX}/ferrydust/
	@cp -f example/rc ${DESTDIR}${SHAREPREFIX}/ferrydust/rc
	@cp -f example/autostart ${DESTDIR}${SHAREPREFIX}/ferrydust/autostart
	@cp -f example/ferryglamour.rc ${DESTDIR}${SHAREPREFIX}/ferrydust/ferryglamour.rc

	@echo "installing udev rules to ${UDEVPREFIX}/rules.d"
	@install -D udev_rules/80-fd-pm.rules ${DESTDIR}${UDEVPREFIX}/rules.d/81-backup.rules

# .PHONY: install
# 	install -d ${DESTDIR}${ETCPREFIX}/powerdown/down
# 	install -d ${DESTDIR}${ETCPREFIX}/powerdown/up
