#!/bin/bash

if [ ! -d openrefine-3.3 ]; then
	wget https://github.com/OpenRefine/OpenRefine/releases/download/3.3/openrefine-linux-3.3.tar.gz
	tar -zxvf openrefine-linux-3.3.tar.gz
	
	mkdir openrefine-3.3/icons
	cp icon.png openrefine-3.3/icons/openrefine.png
fi

if [ -d openrefine-3.3 ]; then
	echo "Packaging OpenRefine"
	rm -rf deb-package
	rm openrefine.deb
	mkdir deb-package
	mkdir -p deb-package/opt/openrefine
	rsync -av --progress openrefine-3.3/* deb-package/opt/openrefine/ --exclude-from=deb-exclude
	rsync -av --progress DEBIAN/ deb-package/DEBIAN/
	chmod -R 0755 deb-package
	dpkg-deb --build deb-package
	mv deb-package.deb openrefine-3.3.deb
fi
