FROM passbolt/passbolt:3.8.3-1-ce

# NOTE --chown www-data:www-data NOT needed when running as root
COPY docker-entrypoint-extended.sh /docker-entrypoint-extended.sh

CMD ["/docker-entrypoint-extended.sh"]