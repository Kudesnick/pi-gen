build:
	sudo update-binfmts --enable && sudo bash ./build.sh

clean:
	sudo rm -fr work deploy

rebuild:
	sudo rm -fr work deploy && sudo update-binfmts --enable && sudo bash ./build.sh
