FROM debian:jessie

RUN sed -i "s/jessie main/jessie main contrib non-free/" /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
	apt install -y apache2 php5 mysql-server procps php5-cli php5-mysql \
		php5-xmlrpc php5-curl php5-gmp php5-mcrypt mcrypt php5-gd \
		par2 rar unrar coreutils tar cksfv \
		trickle arj p7zip-full unace-nonfree unzip subdownloader \
		git wget build-essential

RUN php5enmod mcrypt

RUN cd /var/www/html && git clone https://github.com/gavinspearhead/urd.git

RUN chown www-data:www-data -R /var/www/html/urd && chmod -R u+w /var/www/html/urd

RUN echo 'date.timezone = "Europe/Paris"' >> /etc/php5/cli/php.ini
RUN echo 'date.timezone = "Europe/Paris"' >> /etc/php5/apache2/php.ini

RUN \
	wget 'https://downloads.sourceforge.net/project/yydecode/yydecode/0.2.10/yydecode-0.2.10.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fyydecode%2Ffiles%2F&ts=1496068578&use_mirror=freefr' -O yydecode.tar.gz && \
	tar xf yydecode.tar.gz && \
	rm yydecode.tar.gz && \
	cd yydecode* && \
	./configure --prefix=/usr && \
	make -j4 && \
	make install && \
	rm -Rf yydecode*

