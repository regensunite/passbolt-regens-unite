FROM mysql:5-debian

# install scp command
RUN set -eux; \
	      apt-get update; \
	      apt-get install -y --no-install-recommends \
		            openssh-client \
	    ; \
	    rm -rf /var/lib/apt/lists/*
