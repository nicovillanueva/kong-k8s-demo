ADMIN=$(minikube service --url kong-admin)
PROXY=$(minikube service --url kong-proxy)

- Levantar Kubernetes
- Levantar PostgreSQL
    - Correr migration
- Levantar Kong
    - Mostrar proxy endpoint (vacio)
    - Mostrar admin endpoint

- Proxy simple a httpbin
    # Crear upstream en root
    http POST $ADMIN/apis name=httpbin uris=/ upstream_url=https://httpbin.org

- Restriccion por ACL

    # Crear endpoint `secret` (to be ACL'd)
    http POST $ADMIN/apis name=secret uris=/secret upstream_url=https://httpbin.org/post
    # Agregarle key-based auth
    http post $ADMIN/apis/secret/plugins name=key-auth config.key_names=apikey
    # Unauthorized :(
    http $PROXY/secret

    # Crear un consumer
    http $ADMIN/consumers username=meetup

    # Crearle API Key al consumer
    http POST $ADMIN/consumers/meetup/key-auth  -f ''
    # Authenticated call
    http POST $PROXY/secret apikey:<apikey> foo=bar -f

- Rate limiting
    # Crear endpoint para ser limitado
    http POST $ADMIN/apis name=limited uris=/limited upstream_url=https://httpbin.org/headers
    http POST $ADMIN/apis/limited/plugins name=rate-limiting config.minute=5 config.hour=10 config.year=5000

    # Endpoint que limita consumer particular
    http POST $ADMIN/apis name=consumer_limited uris=/limited2 upstream_url=https://httpbin.org/anything
    http POST $ADMIN/apis/consumer_limited/plugins name=rate-limiting config.second=1 consumer_id=...

- Canary deploy
    # Crear upstream
    http POST $ADMIN/upstreams name=demo.v2.service

    # Asignarle targets
    http POST $ADMIN/upstreams/demo.v2.service/targets target=<ip_interna>:5000 weight=100
    http POST $ADMIN/upstreams/demo.v2.service/targets target=<ip_interna>:5000 weight=10

    # API que vaya al upstream
    http $ADMIN/apis name=canary upstream_url=http://demo.v2.service/ uris=/

    # Rebalance (no se pueden editar; el `created_at` mas reciente es el activo)
    http POST $ADMIN/upstreams/demo.v2.service/targets target=<ip_interna>:5000 weight=50
    http POST $ADMIN/upstreams/demo.v2.service/targets target=<ip_interna>:5000 weight=50

    http POST $ADMIN/upstreams/demo.v2.service/targets target=<ip_interna>:5000 weight=10
    http POST $ADMIN/upstreams/demo.v2.service/targets target=<ip_interna>:5000 weight=90

    http POST $ADMIN/upstreams/demo.v2.service/targets target=<ip_interna>:5000 weight=0
    http POST $ADMIN/upstreams/demo.v2.service/targets target=<ip_interna>:5000 weight=100


- Datadog logging
    # TODO?
