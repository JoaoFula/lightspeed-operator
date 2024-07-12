FROM scratch

# Core bundle labels.
LABEL operators.operatorframework.io.bundle.mediatype.v1=registry+v1
LABEL operators.operatorframework.io.bundle.manifests.v1=manifests/
LABEL operators.operatorframework.io.bundle.metadata.v1=metadata/
LABEL operators.operatorframework.io.bundle.package.v1=lightspeed-operator
LABEL operators.operatorframework.io.bundle.channels.v1=preview
LABEL operators.operatorframework.io.bundle.channel.default.v1=preview
LABEL operators.operatorframework.io.metrics.builder=operator-sdk-v1.33.0
LABEL operators.operatorframework.io.metrics.mediatype.v1=metrics+v1
LABEL operators.operatorframework.io.metrics.project_layout=go.kubebuilder.io/v4

# Labels for enterprise contract
LABEL com.redhat.component=openshift-lightspeed
LABEL description="Red Hat OpenShift Lightspeed"
LABEL distribution-scope=public
LABEL io.k8s.description="Red Hat OpenShift Lightspeed"
LABEL name=openshift-lightspeed
LABEL release=0.0.1
LABEL url="https://github.com/openshift/lightspeed-operator"
LABEL vendor="Red Hat"
LABEL version=0.0.1

# Labels for testing.
LABEL operators.operatorframework.io.test.mediatype.v1=scorecard+v1
LABEL operators.operatorframework.io.test.config.v1=tests/scorecard/

# Copy files to locations specified by labels.
COPY bundle/manifests /manifests/
COPY bundle/metadata /metadata/
COPY bundle/tests/scorecard /tests/scorecard/
