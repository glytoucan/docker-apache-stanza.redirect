build:
	sudo docker build -t aoki/apache-stanza.redirect .

buildrev:
	sudo docker build -t aoki/apache-stanza.redirect_20150715 .

buildnc:
	sudo docker build --no-cache -t aoki/apache-stanza.redirect .

run:
	sudo docker run -d -h local.apache-stanza.redirect -v /opt/apache-stanza.redirect/apachelogs:/var/log/apache2 --name="apache-stanza.redirect" aoki/apache-stanza.redirect

bash:
	sudo docker run --rm -it -h local.apache-stanza.redirect -v /opt/apache-stanza.redirect/tmp:/var/www/apache-stanza.redirect.org/app/tmp --link docker-virtuoso_bluetree:test.ts.apache-stanza.redirect.org --link glyspacesquid_bluetree:apache-stanza.redirect.org --link stanza_bluetree:stanza aoki/apache-stanza.redirect /bin/bash

bashdev:
	sudo docker run --rm -it -h local.apache-stanza.redirect -p 81:80 -v /opt/apache-stanza.redirect/tmp:/tmp/apache-stanza.redirect -v /home/aoki/workspace/apache-stanza.redirect:/tmp/apache-stanza.redirect.org aoki/apache-stanza.redirect_dev /bin/bash

ps:
	sudo docker ps

stop:
	sudo docker stop apache-stanza.redirect

rm:
	sudo docker rm apache-stanza.redirect

logs:
	sudo docker logs apache-stanza.redirect

ip:
	sudo docker inspect -f "{{ .NetworkSettings.IPAddress }}" apache-stanza.redirect

restart:
	sudo docker restart apache-stanza.redirect

inspect:
	sudo docker inspect aoki/apache-stanza.redirect

rerun: stop rm rund

cleandev: builddev stop rm rundev

cleandevstanza: builddev stopdev rmdev rundevstanza

clean: build stop rm rund

# not tested
dump:
	sudo docker export apache-stanza.redirect> apache-stanza.redirect.glycoinfo.tar

# not tested
load:
	cat apache-stanza.redirect.glycoinfo.tar | docker import - aoki/docker-apache-stanza.redirect:apache-stanza.redirect
	
.PHONY: build run test clean
