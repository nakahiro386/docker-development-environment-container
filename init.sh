#!/usr/bin/env bash

CURRENT=$(cd $(dirname $0);pwd)
# 空ディレクトリでなければ起動できないため、.gitkeepを配置しておくことができない
mkdir -p "${CURRENT}/gb-postgres/pgdata"
mkdir -p "${CURRENT}/gitea-db/pgdata"
mkdir -p "${CURRENT}/jenkins/home"
mkdir -p "${CURRENT}/jenkins-agent/home"

DOTENV=${CURRENT}/.env
if [ -r "${DOTENV}" ]; then
    source "${DOTENV}"
fi

docker run \
-it --rm \
-e CA_KEY="${CA_KEY:-ca-key.pem}" \
-e CA_CERT="${CA_CERT:-ca.pem}" \
-e CA_SUBJECT="${CA_SUBJECT:-test-ca}" \
-e CA_EXPIRE="${CA_EXPIRE:-60}" \
-e SSL_CONFIG="${SSL_CONFIG:-openssl.cnf}" \
-e SSL_KEY="${SSL:-key.pem}" \
-e SSL_CSR="${SSL_CSR:-key.csr}" \
-e SSL_CERT="${SSL_CERT:-cert.pem}" \
-e SSL_SIZE="${SSL_SIZE:-2048}" \
-e SSL_EXPIRE="${SSL_EXPIRE:-60}" \
-e SSL_SUBJECT="${SSL_SUBJECT:-$HOSTNAME}" \
-e SSL_DNS="${SSL_DNS:-$HOSTNAME}" \
-v ${CURRENT}/certs:/certs \
--name omgwtfssl \
paulczar/omgwtfssl

cp -f "${CURRENT}/certs/cert.pem" "${CURRENT}/jenkins/build/cert.pem.override"
cp -f "${CURRENT}/certs/cert.pem" "${CURRENT}/jenkins-agent/build/cert.pem"
