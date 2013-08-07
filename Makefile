PREFIX="/usr/local"

install:
	@echo "installing scripts to ${PREFIX}/bin"
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f fd-* ferrycharm ferrysparkle ferryrandr ${DESTDIR}${PREFIX}/bin

.PHONY: install



