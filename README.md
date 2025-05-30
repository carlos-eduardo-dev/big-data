helm upgrade --install airflow ./charts/airflow \
--namespace airflow --create-namespace \
--values ./charts/airflow/env/airflow-defaults.yml

helm upgrade --install spark-operator ./charts/spark-operator \
--namespace spark-operator --create-namespace \
--values ./charts/spark-operator/env/spark-operator-defaults.yml

helm upgrade --install local-minio-tenant ./charts/minio-tenant \
--namespace local-minio-tenant --create-namespace \
--values ./charts/minio-tenant/env/minio-tenant-defaults.yml

helm upgrade --install minio-operator ./charts/minio-operator \
--namespace minio-operator --create-namespace \
--values ./charts/minio-operator/env/minio-operator-defaults.yml

helm upgrade --install nessie ./charts/nessie \
--namespace nessie --create-namespace \
--values ./charts/nessie/env/nessie-defaults.yml

helm upgrade --install trino ./charts/trino \
--namespace trino --create-namespace \
--values ./charts/trino/env/trino-defaults.yml

helm upgrade --install dremio ./charts/dremio \
--namespace dremio --create-namespace \
--values ./charts/dremio/env/dremio-defaults.yml

helm upgrade --install longhorn ./charts/longhorn \
--namespace longhorn --create-namespace \
--values ./charts/longhorn/env/longhorn-defaults.yml

- host precisa de ter bin mkisofs

helm upgrade --install redis-operator ./charts/redis-operator \
--namespace redis-operator --create-namespace \
--values ./charts/redis-operator/env/redis-operator-defaults.yml

helm upgrade --install postgres-operator ./charts/postgres-operator \
--namespace postgres-operator --create-namespace \
--values ./charts/postgres-operator/env/postgres-operator-defaults.yml

helm upgrade --install postgres-operator-ui ./charts/postgres-operator-ui \
--namespace postgres-operator --create-namespace \
--values ./charts/postgres-operator-ui/env/postgres-operator-ui-defaults.yml

helm upgrade --install argo ./charts/argo-cd \
--namespace argo --create-namespace \
--values ./charts/argo-cd/env/argo-defaults.yml

helm upgrade --install metallb ./charts/metallb \
--namespace metallb-system --create-namespace \
--values ./charts/metallb/env/metallb-defaults.yml

helm upgrade --install istio-base ./charts/istio-base \
--namespace istio-system --create-namespace \
--values ./charts/istio-base/env/istio-base-defaults.yml

helm upgrade --install istio-cni ./charts/istio-cni \
--namespace istio-system --create-namespace \
--values ./charts/istio-cni/env/istio-cni-defaults.yml --wait

helm upgrade --install istio-istiod ./charts/istio-istiod \
--namespace istio-system --create-namespace \
--values ./charts/istio-istiod/env/istio-istiod-defaults.yml --wait

helm upgrade --install istio-gateway ./charts/istio-gateway \
--namespace istio-ingress --create-namespace \
--values ./charts/istio-gateway/env/istio-gateway-defaults.yml --wait

helm upgrade --install kube-prometheus-stack ./charts/kube-prometheus-stack \
--namespace monitoring --create-namespace \
--values ./charts/kube-prometheus-stack/env/kube-prometheus-stack-defaults.yml --wait

helm upgrade --install kiali-operator ./charts/kiali-operator \
--namespace kiali-operator --create-namespace \
--values ./charts/kiali-operator/env/kiali-operator-defaults.yml --wait

helm upgrade --install kiali-server ./charts/kiali-server \
--namespace istio-system --create-namespace \
--values ./charts/kiali-server/env/kiali-server-defaults.yml --wait

helm upgrade --install master-gateway ./charts/applications-gateway \
--namespace istio-ingress --create-namespace \
--values ./charts/applications-gateway/values.yaml --wait

helm upgrade --install cert-manager ./charts/cert-manager \
--namespace cert-manager --create-namespace \
--values ./charts/cert-manager/env/cert-manager-defaults.yml --wait