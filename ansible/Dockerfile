FROM python:3.8-buster

ENV TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "-g", "--"]

COPY Pipfile* /

RUN set -x \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -q \
  && apt-get upgrade -y -q \
  && apt-get install -y -q --no-install-recommends --auto-remove libldap2-dev libsasl2-dev \
  && rm -rf /var/lib/apt/lists /var/cache/apt/archives

RUN set -x \
  && pip install --no-cache-dir -U pip setuptools \
  && pip install --no-cache-dir pipenv \
  && pipenv sync --system --bare --clear \
  && pipenv --rm

ARG ANSIBLE_EXEC_UID="1000"
ARG ANSIBLE_EXEC_GID="1000"
ARG ANSIBLE_EXEC_USER="ansible"
ARG ANSIBLE_EXEC_GROUP="ansible"

RUN set -x \
  && groupadd -g ${ANSIBLE_EXEC_GID} ${ANSIBLE_EXEC_GROUP} \
  && useradd -m -u ${ANSIBLE_EXEC_UID} -g ${ANSIBLE_EXEC_GID} ${ANSIBLE_EXEC_USER}

USER ${ANSIBLE_EXEC_USER}
