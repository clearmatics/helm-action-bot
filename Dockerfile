FROM alpine:3.10.2

ENV BASE_URL="https://get.helm.sh"

ENV HELM_2_FILE="helm-v2.16.1-linux-amd64.tar.gz"
ENV HELM_3_FILE="helm-v3.0.0-linux-amd64.tar.gz"
ENV HELM_SRC_REPO="charts-ose.clearmatics.com"

RUN apk add --no-cache ca-certificates jq curl bash nodejs && \
    # Install helm version 2:
    curl -L ${BASE_URL}/${HELM_2_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    # Install helm version 3:
    curl -L ${BASE_URL}/${HELM_3_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm3 && \
    chmod +x /usr/bin/helm3 && \
    rm -rf linux-amd64 && \
    # Init version 2 helm:
    helm init --client-only && \
    curl -L https://charts-ose.clearmatics.com/autonity-1.1.1.tgz && \
    ls -a
    # update the helm repo:
    # helm repo add ${HELM_SRC_REPO} https://${HELM_SRC_REPO}:
    # helm repo list:

COPY . /usr/src/
ENTRYPOINT ["node", "/usr/src/index.js"]
