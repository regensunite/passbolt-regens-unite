FROM passbolt/passbolt:3.8.3-1-ce

# install scp command
RUN set -eux; \
	      apt-get update; \
	      apt-get install -y --no-install-recommends \
		            openssh-client \
	    ; \
	    rm -rf /var/lib/apt/lists/*

# NOTE --chown www-data:www-data NOT needed when running as root
COPY docker-entrypoint-extended.sh /docker-entrypoint-extended.sh

CMD ["/docker-entrypoint-extended.sh"]