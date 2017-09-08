kubectl create -f k8s/postgres.yaml
kubectl create -f k8s/postgres_migration.yaml
#kubectl delete -f k8s/postgres_migration.yaml
kubectl create -f k8s/kong.yaml
