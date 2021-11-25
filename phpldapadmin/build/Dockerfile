FROM osixia/phpldapadmin:stable
# Locale localization seems unavailable · Issue #55 · osixia/docker-phpLDAPadmin
# https://github.com/osixia/docker-phpLDAPadmin/issues/55
RUN sed -i -e 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen \
  && dpkg-reconfigure --frontend=noninteractive locales
