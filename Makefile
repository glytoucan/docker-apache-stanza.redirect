build:
	sudo docker build -t aoki/apache-stanza.redirect .

buildrev:
	sudo docker build -t aoki/apache-stanza.redirect_20150715 .

builddev:
	sudo docker build -f Dockerfile.dev -t aoki/apache-stanza.redirect_dev .

buildtest:
	sudo docker build -f Dockerfile.test -t aoki/apache-stanza.redirect_test .

buildnc:
	sudo docker build --no-cache -t aoki/apache-stanza.redirect .

run:
	sudo docker run -d -h local.apache-stanza.redirect -v /opt/apache-stanza.redirect/apachelogs:/var/log/apache2 --name="apache-stanza.redirect" aoki/apache-stanza.redirect

runtest:
	sudo docker run -d -h local.apache-stanza.redirect -p 90:80 -v /opt/apache-stanza.redirect/tmp:/var/www/apache-stanza.redirect.org/app/tmp -v /mnt/jenkins/workspace/apache-stanza.redirect:/tmp/apache-stanza.redirect.org -v /opt/apache-stanza.redirect/apachelogs:/var/log/apache2 --link glyspacesquid_bluetree:test.apache-stanza.redirect.org --link stanza_bluetree:stanza.apache-stanza.redirect.org --name="apache-stanza.redirect" aoki/apache-stanza.redirect_test

runbeta:
	sudo docker run -d -h local.apache-stanza.redirect -p 91:80 --link glyspace_bluetree:test.apache-stanza.redirect.org --link beta.apache-stanza.redirect:rdf.apache-stanza.redirect.org --name="apache-stanza.redirect" -v /opt/beta.apache-stanza.redirect/apachelogs:/var/log/apache2 --link stanza_bluetree:stanza.apache-stanza.redirect.org --name="beta.apache.apache-stanza.redirect" aoki/apache-stanza.redirect
	#sudo docker run -d -h local.apache-stanza.redirect -p 90:80 -v /opt/apache-stanza.redirect/tmp:/var/www/apache-stanza.redirect.org/app/tmp -v /mnt/jenkins/workspace/apache-stanza.redirect:/tmp/apache-stanza.redirect.org -v /opt/apache-stanza.redirect/apachelogs:/var/log/apache2 --link glyspacesquid_bluetree:test.apache-stanza.redirect.org --link stanza_bluetree:stanza.apache-stanza.redirect.org --name="apache-stanza.redirect" aoki/apache-stanza.redirect_test

runbranch:
	sudo docker run -d -h local.apache-stanza.redirect -p 92:80 -v /opt/apache-stanza.redirectbranch/tmp:/var/www/apache-stanza.redirect.org/app/tmp -v /mnt/jenkins/workspace/apache-stanza.redirect-branch:/tmp/apache-stanza.redirect.org -v /opt/apache-stanza.redirectbranch/apachelogs:/var/log/apache2 --link glyspacesquid_bluetree:test.apache-stanza.redirect.org --name="apache-stanza.redirect_branch" aoki/apache-stanza.redirect_dev

rundev:
	sudo docker run -d -h local.apache-stanza.redirect --link docker-virtuoso_bluetree:test.ts.glytoucan.org --name="apache-stanza.redirect" aoki/apache-stanza.redirect

rundevstanza:
	sudo docker run -d -h local.apache-stanza.redirect -p 83:80 -v /opt/apache-stanza.redirect/tmp:/var/www/apache-stanza.redirect.org/app/tmp -v ~/workspace/apache-stanza.redirect:/tmp/apache-stanza.redirect.org --name="apache-stanza.redirect" --link stanza_bluetree:stanza.apache-stanza.redirect.org aoki/apache-stanza.redirect_dev

rundevglyspace:
	sudo docker run -d -h local.apache-stanza.redirect -p 83:80 -v /opt/apache-stanza.redirect/tmp:/var/www/apache-stanza.redirect.org/app/tmp -v ~/workspace/apache-stanza.redirect:/tmp/apache-stanza.redirect.org --link glyspacesquid_bluetree:test.apache-stanza.redirect.org --name="apache-stanza.redirect" aoki/apache-stanza.redirect_dev

bash:
	sudo docker run --rm -it -h local.apache-stanza.redirect -v /opt/apache-stanza.redirect/tmp:/var/www/apache-stanza.redirect.org/app/tmp --link docker-virtuoso_bluetree:test.ts.apache-stanza.redirect.org --link glyspacesquid_bluetree:apache-stanza.redirect.org --link stanza_bluetree:stanza aoki/apache-stanza.redirect /bin/bash

bashdev:
	sudo docker run --rm -it -h local.apache-stanza.redirect -p 81:80 -v /opt/apache-stanza.redirect/tmp:/tmp/apache-stanza.redirect -v /home/aoki/workspace/apache-stanza.redirect:/tmp/apache-stanza.redirect.org aoki/apache-stanza.redirect_dev /bin/bash

bashtest:
	sudo docker run --rm -it -h local.apache-stanza.redirect -p 82:80 -v /opt/apache-stanza.redirect/tmp:/var/www/apache-stanza.redirect.org/app/tmp -v /mnt/jenkins/workspace/apache-stanza.redirect:/tmp/apache-stanza.redirect.org --link glyspacesquid_bluetree:test.apache-stanza.redirect.org --link stanza_bluetree:stanza.apache-stanza.redirect.org aoki/apache-stanza.redirect_dev /bin/bash

ps:
	sudo docker ps

stop:
	sudo docker stop apache-stanza.redirect

rm:
	sudo docker rm apache-stanza.redirect

logs:
	sudo docker logs apache-stanza.redirect

cleanbranch:
	sudo docker stop apache-stanza.redirect_branch
	sudo docker rm apache-stanza.redirect_branch

cleanbeta:
	sudo docker stop beta.apache.apache-stanza.redirect
	sudo docker rm beta.apache.apache-stanza.redirect

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
