FROM		dockerworks/ubuntu-apache2
MAINTAINER	technopreneural@yahoo.com

			# Install latest updates (security best practice)
RUN			apt-get update \
			&& apt-get upgrade -y \

			# Install packages (without asking for user input)
			&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
				curl \
				git \
				libapache2-mod-php7.0 \
				php7.0 \
				php7.0-cli \
				php7.0-curl \
				php7.0-gd \
				php7.0-intl \
				php7.0-mbstring \
				php7.0-mcrypt \
				php7.0-mysql \
				php7.0-xml \

			# Enable MCrypt
			&& phpenmod mcrypt \

			# Remove repo lists (reduce image size)
			&& rm -rf /var/lib/apt/lists/*

			# Download Composer
RUN			php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \

			# Verify installer
			&& php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \

			# Install Composer
			&& php composer-setup.php \
			&& php -r "unlink('composer-setup.php');" \
			&& mv composer.phar /usr/local/bin/composer
