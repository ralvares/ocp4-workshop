apiVersion: operator.openshift.io/v1
kind: IngressController
metadata:
  name: internal-apps
  namespace: openshift-ingress-operator
spec:
  replicas: 3
  domain: ${INTERNAL_APPS_DNS_DOMAIN}
  defaultCertificate:
    name: internal-apps-cert
  nodePlacement:
    nodeSelector:
      matchLabels:
        node-role.kubernetes.io/infra: ""
  namespaceSelector:
    matchLabels:
      ingress-traffic.opentlc.com/internal: ""
  routeSelector:
    matchLabels:
      route-type: internal
  endpointPublishingStrategy:
    type: LoadBalancerService
    loadBalancer:
      scope: Internal
