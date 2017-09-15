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

    # Crear endpoint `post` (to be ACL'd)
    http POST $ADMIN/apis name=post uris=/post upstream_url=https://httpbin.org/post
    # Agregarle key-based auth
    http post $ADMIN/apis/post/plugins name=key-auth config.key_names=apikey
    # Unauthorized :(
    http $PROXY/post

    # Crear un consumer
    http $ADMIN/consumers username=meetup

    # Crearle API Key al consumer
    http POST $ADMIN/consumers/meetup/key-auth  -f ''
    # Authenticated call
    http POST $PROXY/post apikey:<apikey> foo=bar -f

- Rate limiting
    # Proteger puntos
    http POST $ADMIN/apis/puntos/plugins name=rate-limiting config.minute=5 config.hour=10 config.year=5000

Rate limiting por API
Rate limiting por consumer

Canary deploy
Datadog logging
