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

helm upgrade --install postgres-operator ./charts/postgres-operator \
--namespace postgres-operator --create-namespace \
--values ./charts/postgres-operator/env/postgres-operator-defaults.yml

helm upgrade --install postgres-operator-ui ./charts/postgres-operator-ui \
--namespace postgres-operator --create-namespace \
--values ./charts/postgres-operator-ui/env/postgres-operator-ui-defaults.yml

helm upgrade --install argo ./charts/argo-cd \
--namespace argo --create-namespace \
--values ./charts/argo-cd/env/argo-defaults.yml

