FROM jenkins/jenkins:2.303.3-lts

ARG SSL_SUBJECT
ARG NGINX_SSL_PORT
ENV JENKINS_OPTS="--prefix=/jenkins" \
    JAVA_OPTS="-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"
STOPSIGNAL SIGINT
HEALTHCHECK --retries=10 CMD ["curl", "-fsSI", "--output", "/dev/null", "http://127.0.0.1:8080/jenkins"]

COPY ["plugins.txt", "cert.pem.override", "jenkins.yaml.override", "/usr/share/jenkins/ref/"]
RUN set -x \
  && git config -f /usr/share/jenkins/ref/.gitconfig.override http."https://${SSL_SUBJECT}:${NGINX_SSL_PORT}/".sslCAInfo /var/jenkins_home/cert.pem
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt \
  && jenkins-plugin-cli --list
