FROM openjdk:8-buster

ARG SSL_SUBJECT
ARG NGINX_SSL_PORT
ARG JENKINS_SWARM_VERSION=3.28
ARG JENKINS_SWARM_CLIENT_URL=https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${JENKINS_SWARM_VERSION}/swarm-client-${JENKINS_SWARM_VERSION}.jar
ARG JENKINS_AGENT_UID=1000
ARG JENKINS_AGENT_GID=1000
ARG JENKINS_AGENT_USER=jenkins-agent
ARG JENKINS_AGENT_GROUP=jenkins-agent
ARG JENKINS_AGENT_HOME=/home/jenkins-agent

ENV TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "-g", "--"]

COPY ["cert.pem", "jenkins-slave.sh", "/usr/share/jenkins/"]
RUN set -x \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -q \
  && apt-get upgrade -y -q \
  && apt-get install -y -q --no-install-recommends --auto-remove ncat \
  && rm -rf /var/lib/apt/lists /var/cache/apt/archives \
  && curl --create-dirs -sSLo /usr/share/jenkins/swarm-client.jar ${JENKINS_SWARM_CLIENT_URL} \
  && chmod -R 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/swarm-client.jar \
  && keytool -import -trustcacerts -noprompt -alias test-ca -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -file /usr/share/jenkins/cert.pem \
  && git config --system http."https://${SSL_SUBJECT}:${NGINX_SSL_PORT}/".sslCAInfo /usr/share/jenkins/cert.pem \
  && groupadd -g ${JENKINS_AGENT_GID} ${JENKINS_AGENT_GROUP} \
  && useradd -u ${JENKINS_AGENT_UID} -g ${JENKINS_AGENT_GID} -m -d ${JENKINS_AGENT_HOME} ${JENKINS_AGENT_USER}

USER ${JENKINS_AGENT_USER}
WORKDIR ${JENKINS_AGENT_HOME}
CMD ["/usr/share/jenkins/jenkins-slave.sh"]
