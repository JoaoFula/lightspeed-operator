FROM registry.redhat.io/ubi9/ubi-minimal:9.6 as builder
ARG RELATED_IMAGE_FILE=related_images.json
ARG CSV_FILE=bundle/manifests/lightspeed-operator.clusterserviceversion.yaml
ARG OPERATOR_IMAGE_ORIGINAL=quay.io/openshift-lightspeed/lightspeed-operator:latest
ARG SERVICE_IMAGE_ORIGINAL=quay.io/openshift-lightspeed/lightspeed-service-api:latest
ARG CONSOLE_IMAGE_ORIGINAL=quay.io/openshift-lightspeed/lightspeed-console-plugin:latest

RUN microdnf install -y jq

COPY ${CSV_FILE} /manifests/lightspeed-operator.clusterserviceversion.yaml
COPY ${RELATED_IMAGE_FILE} /${RELATED_IMAGE_FILE}

RUN OPERATOR_IMAGE=$(jq -r '.[] | select(.name == "lightspeed-operator") | .image' /${RELATED_IMAGE_FILE}) && sed -i "s|${OPERATOR_IMAGE_ORIGINAL}|${OPERATOR_IMAGE}|g" /manifests/lightspeed-operator.clusterserviceversion.yaml
RUN SERVICE_IMAGE=$(jq -r '.[] | select(.name == "lightspeed-service-api") | .image' /${RELATED_IMAGE_FILE}) && sed -i "s|${SERVICE_IMAGE_ORIGINAL}|${SERVICE_IMAGE}|g" /manifests/lightspeed-operator.clusterserviceversion.yaml
RUN CONSOLE_IMAGE=$(jq -r '.[] | select(.name == "lightspeed-console-plugin") | .image' /${RELATED_IMAGE_FILE}) && sed -i "s|${CONSOLE_IMAGE_ORIGINAL}|${CONSOLE_IMAGE}|g" /manifests/lightspeed-operator.clusterserviceversion.yaml

##__GENERATED_CONTAINER_FILE__##

# Copy the CSVfile with replaced images references
COPY --from=builder manifests/lightspeed-operator.clusterserviceversion.yaml /manifests/lightspeed-operator.clusterserviceversion.yaml

# licenses required by Red Hat certification policy
# refer to https://docs.redhat.com/en/documentation/red_hat_software_certification/2024/html-single/red_hat_openshift_software_certification_policy_guide/index#con-image-content-requirements_openshift-sw-cert-policy-container-images
COPY LICENSE /licenses/

# Labels for enterprise contract
LABEL com.redhat.component=openshift-lightspeed
LABEL description="Red Hat OpenShift Lightspeed - AI assistant for managing OpenShift clusters."
LABEL distribution-scope=public
LABEL io.k8s.description="Red Hat OpenShift Lightspeed - AI assistant for managing OpenShift clusters."
LABEL io.k8s.display-name="Openshift Lightspeed"
LABEL io.openshift.tags="openshift,lightspeed,ai,assistant"
LABEL name=openshift-lightspeed
LABEL release={BUNDLE_VERSION}
LABEL url="https://github.com/openshift/lightspeed-operator"
LABEL vendor="Red Hat, Inc."
LABEL version={BUNDLE_VERSION}
LABEL summary="Red Hat OpenShift Lightspeed"

# OCP compatibility labels
LABEL com.redhat.openshift.versions=v4.15-v4.19

# Set user to non-root for security reasons.
USER 1001
