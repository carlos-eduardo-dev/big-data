helm upgrade --install airflow ./charts/airflow \
--namespace airflow --create-namespace \
--values ./charts/airflow/env/airflow-defaults.yml

helm install spark-operator ./charts/spark-operator \
--namespace spark-operator --create-namespace \
--values ./charts/spark-operator/env/spark-operator-defaults.yml --wait

helm install \
--namespace local-minio-tenant \
--create-namespace \
--values minio-tenant-defaults.yml \
local-minio-tenant minio-operator/tenant

helm install \
--namespace minio-operator \
--create-namespace \
operator minio-operator/operator -f minio-operator-defaults.yml