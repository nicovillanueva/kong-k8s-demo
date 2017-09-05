## Crear Postgres
    kubectl create -f k8s/postgres.yaml

## Preparar Postgres para Kong (one-shot job)
    kubectl create -f k8s/postgres_migration.yaml
    kubectl delete -f k8s/postgres_migration.yaml

## Crear Kong
    kubectl create -f k8s/kong.yaml

## Verificar que esté todo arriba
    kubectl get all

### (Minikube)
IPs:
- `minikube service --url kong-admin`
- `minikube service --url kong-proxy`

## Konga
    kubectl create -f k8s/konga.yaml
