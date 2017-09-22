# APIsAR - Episode VI

Demo de la Meetup de APIsAR sobre Kong: https://www.meetup.com/es-ES/preview/APIsAR/events/243084908

Preparada para correr sobre Kubernetes. Funciona en local (con minikube), debería funcionar en clusters remotos.

## Minikube
El mejor invento después del pan lactal: https://github.com/kubernetes/minikube

## Crear Postgres
    kubectl create -f k8s/postgres.yaml

## Preparar Postgres para Kong (one-shot job)
    kubectl create -f k8s/postgres_migration.yaml

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

    kubectl delete -f k8s/postgres_kongadb.yaml
    kubectl delete -f k8s/postgres_migration.yaml

## Pendiente!
No se mostró lo que es el monitoreo mediante Datadog. Asimismo, en la carpeta `monitoring/` está el .yml para deployar el agente de DD, preconfigurado para monitorear Kong. **Previo a crearlo**, editarlo y agregarle una API key válida (en `spec.template.spec.containers.env`)
