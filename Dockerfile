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
				php7.0-mcrypt \
				php7.0-mysql \

			# Enable MCrypt
			&& phpenmod mcrypt \

			# Remove repo lists (reduce image size)
			&& rm -rf /var/lib/apt/lists/*

			# Download Composer
RUN			php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \

			# Verify installer
			&& php -r "if (hash_file('SHA384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \

			# Install Composer
			&& php composer-setup.php \
			&& php -r "unlink('composer-setup.php');" \
			&& mv composer.phar /usr/local/bin/composer
