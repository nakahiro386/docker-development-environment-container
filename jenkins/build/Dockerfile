FROM jenkins/jenkins:2.303.2-lts

ARG SSL_SUBJECT
ARG NGINX_SSL_PORT
ENV JENKINS_OPTS="--prefix=/jenkins" \
    JAVA_OPTS="-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

COPY ["plugins.txt", "cert.pem.override", "jenkins.yaml.override", "/usr/share/jenkins/ref/"]
RUN set -x \
  && git config -f /usr/share/jenkins/ref/.gitconfig.override http."https://${SSL_SUBJECT}:${NGINX_SSL_PORT}/".sslCAInfo /var/jenkins_home/cert.pem
RUN set -x \
  && jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
