all:
	git clone git@github.com:FabriceLuo/keys.git
	install -b -D -g $(DEVELOP_USER) -o $(DEVELOP_USER) -m 0600 ./keys/ssh/id_rsa /home/$(DEVELOP_USER)/.ssh/id_rsa
	install -b -D -g $(DEVELOP_USER) -o $(DEVELOP_USER) -m 0600 ./keys/ssh/id_rsa.pub /home/$(DEVELOP_USER)/.ssh/id_rsa.pub
