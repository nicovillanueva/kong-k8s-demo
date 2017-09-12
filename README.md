## Crear Postgres
    kubectl create -f k8s/postgres.yaml

## Preparar Postgres para Kong (one-shot job)
    kubectl create -f k8s/postgres_migration.yaml
    kubectl delete -f k8s/postgres_migration.yaml

## Crear Kong
    kubectl create -f k8s/kong.yaml

## Verificar que esté todo arriba
    kubectl get all

### Minikube
URLs:
- `minikube service --url kong-admin`
- `minikube service --url kong-proxy`
- `minikube service --url konga`

## Konga
### Precondition
Crear la DB `konga_database`

    kubectl create -f k8s/postgres_kongadb.yaml

### Install
    kubectl create -f k8s/konga.yaml

### Config
- Kong Connection: http://kong-admin:8001
- Username: admin
- Password: adminadminadmin

## Limpiar jobs

    kubectl delete job konga-db-create
    kubectl delete job kong-migration
