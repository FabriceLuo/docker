FROM nextcloud:21.0 as base_image

ENV CLOUD_CERT_DIR="/etc/ssl/certs/cloud"
env APACHE_SITES_AVAIL_DIR="/etc/apache2/sites-available"
env APACHE_SITES_ENABLE_DIR="/etc/apache2/sites-enabled"
env APACHE_MODS_ENABLE_DIR="/etc/apache2/mods-enabled"

LABEL "name"="nextcloud-image"
LABEL "distribution"="nextcloud image with https"
LABEL "description"="nextcloud image with https"
LABEL "version"="1.2"

RUN mkdir ${CLOUD_CERT_DIR}

COPY --chown=root:root certs ${CLOUD_CERT_DIR}

COPY --chown=root:root apache2/000-default.conf ${APACHE_SITES_AVAIL_DIR}
COPY --chown=root:root apache2/default-ssl.conf ${APACHE_SITES_AVAIL_DIR}

RUN cd ${APACHE_SITES_ENABLE_DIR} && ln -s ../sites-available/default-ssl.conf default-ssl.conf
RUN cd ${APACHE_MODS_ENABLE_DIR} && ln -s ../mods-available/ssl.conf ssl.conf
RUN cd ${APACHE_MODS_ENABLE_DIR} && ln -s ../mods-available/ssl.load ssl.load
RUN cd ${APACHE_MODS_ENABLE_DIR} && ln -s ../mods-available/socache_shmcb.load socache_shmcb.load
