#!/usr/bin/env bash

PARAMS=""

# YAML configuration file containing the options.
if [ -n "$AGENT_CONFIG" ]; then
    PARAMS="$PARAMS -config $AGENT_CONFIG"
fi

# Delete any existing agent with the same name. (default: false)
if [ "${AGENT_DELETE_EXISTING_CLIENTS,,}" = "true" ]; then
    PARAMS="$PARAMS -deleteExistingClients"
fi

# Description to be put on the agent.
if [ -n "$AGENT_DESCRIPTION" ]; then
    PARAMS="$PARAMS -description \"$AGENT_DESCRIPTION\""
fi

# Disable client’s unique ID. (default: false)
if [ "${AGENT_DELETE_EXISTING_CLIENTS,,}" = "true" ]; then
    PARAMS="$PARAMS -deleteExistingClients"
fi

# Disable client’s unique ID. (default: false)
if [ "${AGENT_DISABLE_SSL_VERIFICATION,,}" = "true" ]; then
    PARAMS="$PARAMS -disableSslVerification"
fi

# Disable Remoting working directory support and run the agent in legacy mode. (default: false)
if [ "${AGENT_DISABLE_WORK_DIR,,}" = "true" ]; then
    PARAMS="$PARAMS -disableWorkDir"
fi

# An environment variable to be defined on this agent. It is specified as `key=value'. Multiple variables are allowed.
if [ -n "$AGENT_ENVS" ]; then
    IFS=, ENVS=(${AGENT_ENVS})
    for e in "${ENVS[@]}"; do
        PARAMS="$PARAMS -e \"$e\""
    done
fi

# Number of executors (default: number of CPUs)
if [ -n "$AGENT_EXECUTORS" ]; then
    PARAMS="$PARAMS -executors $AGENT_EXECUTORS"
fi

# Fail if the requested Remoting working directory or internal directory is missing. (default: false)
if [ "${AGENT_FAIL_IF_WORK_DIR_IS_MISSING,,}" = "true" ]; then
    PARAMS="$PARAMS -failIfWorkDirIsMissing"
fi

# Remote root directory. (default: .)
if [ -n "$AGENT_FSROOT" ]; then
    PARAMS="$PARAMS -fsroot \"$AGENT_FSROOT\""
fi

# The name of the directory within the Remoting working directory where files internal to Remoting will be stored.
if [ -n "$AGENT_INTERNAL_DIR" ]; then
    PARAMS="$PARAMS -internalDir \"$AGENT_INTERNAL_DIR\""
fi

# Cache directory that stores JAR files sent from the controller.
if [ -n "$AGENT_JAR_CACHE" ]; then
    PARAMS="$PARAMS -jar-cache \"$AGENT_JAR_CACHE\""
fi

# Whitespace-separated list of labels to be assigned for this agent. Multiple options are allowed.
if [ -n "$AGENT_LABELS" ]; then
    IFS=, ENVS=(${AGENT_LABELS})
    for e in "${ENVS[@]}"; do
        PARAMS="$PARAMS -labels \"$e\""
    done
fi

# File location with space delimited list of labels. If the file changes, the client is restarted.
if [ -n "$AGENT_LABELS_FILE" ]; then
    PARAMS="$PARAMS -labelsFile \"$AGENT_LABELS_FILE\""
fi

# Max time to wait before retry in seconds. Default is 60 seconds. (default: 60)
if [ -n "$AGENT_MAX_RETRY_INTERVAL" ]; then
    PARAMS="$PARAMS -maxRetryInterval $AGENT_MAX_RETRY_INTERVAL"
fi

# The mode controlling how Jenkins allocates jobs to agents. Can be either `normal' (use this node as much as possible) or `exclusive' (only build jobs with label expressions matching this node). Default is `normal'. (default: normal)
if [ -n "$AGENT_MODE" ]; then
    PARAMS="$PARAMS -mode $AGENT_MODE"
fi

# Name of the agent.
if [ -n "$AGENT_NAME" ]; then
    PARAMS="$PARAMS -name $AGENT_NAME"
fi

# Do not retry if a successful connection gets closed. (default: false)
if [ "${AGENT_NO_RETRY_AFTER_CONNECTED,,}" = "true" ]; then
    PARAMS="$PARAMS -noRetryAfterConnected"
fi

# The Jenkins user API token or password.
if [ -n "$AGENT_PASSWORD" ]; then
    PARAMS="$PARAMS -password $AGENT_PASSWORD"
fi

# Environment variable containing the Jenkins user API token or password.
if [ -n "$AGENT_PASSWORD_ENV_VARIABLE" ]; then
    PARAMS="$PARAMS -passwordEnvVariable $AGENT_PASSWORD_ENV_VARIABLE"
fi

# File containing the Jenkins user API token or password.
if [ -n "$AGENT_PASSWORD_FILE" ]; then
    PARAMS="$PARAMS -passwordFile \"$AGENT_PASSWORD_FILE\""
fi

# File to write PID to. The client will refuse to start if this file exists and the previous process is still running.
if [ -n "$AGENT_PID_FILE" ]; then
    PARAMS="$PARAMS -pidFile \"$AGENT_PID_FILE\""
fi

# If defined, then start an HTTP service on this port for Prometheus metrics. (default: -1)
if [ -n "$AGENT_PROMETHEUS_PORT" ]; then
    PARAMS="$PARAMS -prometheusPort $AGENT_PROMETHEUS_PORT"
fi

# Number of retries before giving up. Unlimited if not specified. (default: -1)
if [ -n "$AGENT_RETRY" ]; then
    PARAMS="$PARAMS -retry $AGENT_RETRY"
fi

# The mode controlling retry wait time. Can be either `none' (use same interval between retries) or `linear' (increase wait time before each retry up to maxRetryInterval) or `exponential' (double wait interval on each retry up to maxRetryInterval). Default is `none'. (default: NONE)
if [ -n "$AGENT_RETRY_BACK_OFF_STRATEGY" ]; then
    PARAMS="$PARAMS -retryBackOffStrategy $AGENT_RETRY_BACK_OFF_STRATEGY"
fi

# Time to wait before retry in seconds. Default is 10 seconds. (default: 10)
if [ -n "$AGENT_RETRY_INTERVAL" ]; then
    PARAMS="$PARAMS -retryInterval $AGENT_RETRY_INTERVAL"
fi

# Whitespace-separated list of accepted certificate fingerprints (SHA-256/Hex), otherwise system truststore will be used. No revocation, expiration or not yet valid check will be performed for custom fingerprints! Multiple options are allowed. (default: )
if [ -n "$AGENT_SSL_FINGERPRINTS" ]; then
    PARAMS="$PARAMS -sslFingerprints \"$AGENT_SSL_FINGERPRINTS\""
fi

# A tool location to be defined on this agent. It is specified as `toolName=location'.
if [ -n "$AGENT_TOOL_LOCATIONS" ]; then
    IFS=, ENVS=(${AGENT_TOOL_LOCATIONS})
    for e in "${ENVS[@]}"; do
        PARAMS="$PARAMS -t \"$e\""
    done
fi

# Connect to the specified host and port, instead of connecting directly to Jenkins. Useful when connection to Jenkins needs to be tunneled. Can be also HOST: or :PORT, in which case the missing portion will be auto-configured like the default behavior
if [ -n "$AGENT_TUNNEL" ]; then
    PARAMS="$PARAMS -tunnel $AGENT_TUNNEL"
fi

# The complete target Jenkins URL like `http://server:8080/jenkins/'.
if [ -n "$AGENT_URL" ]; then
    PARAMS="$PARAMS -url $AGENT_URL"
fi
if [ -n "$JENKINS_URL" ]; then
    PARAMS="$PARAMS -url $JENKINS_URL"
fi

# The Jenkins username for authentication.
if [ -n "$AGENT_USERNAME" ]; then
    PARAMS="$PARAMS -username $AGENT_USERNAME"
fi

# Connect using the WebSocket protocol. (default: false)
if [ "${AGENT_WEB_SOCKET,,}" = "true" ]; then
    PARAMS="$PARAMS -webSocket"
fi

# Additional WebSocket header to set, e.g. for authenticating with reverse proxies. To specify multiple headers, call this flag multiple times, one with each header.
if [ -n "$AGENT_WEB_SOCKET_HEADERS" ]; then
    IFS=, ENVS=(${AGENT_WEB_SOCKET_HEADERS})
    for e in "${ENVS[@]}"; do
        PARAMS="$PARAMS -webSocketHeader \"$e\""
    done
fi

# The Remoting working directory where the JAR cache and logs will be stored.
if [ -n "$AGENT_WORK_DIR" ]; then
    PARAMS="$PARAMS -workDir \"$AGENT_WORK_DIR\""
fi

if [ -n "$AGENT_PARAMS" ]; then
    PARAMS="$PARAMS $AGENT_PARAMS"
fi

exec java $JAVA_OPTS -jar /usr/share/jenkins/swarm-client.jar $PARAMS
