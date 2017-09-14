ADMIN=$(minikube service --url kong-admin)

- Levantar Kubernetes
- Levantar PostgreSQL
    - Correr migration
- Levantar Kong
    - Mostrar proxy endpoint (vacio)
    - Mostrar admin endpoint

- Proxy simple a httpbin
    # Crear upstream en root
    http POST $ADMIN/apis name=httpbin uris=/ upstream_url=https://httpbin.org
    # Borrar para poder crear un uris=/open
    http delete $ADMIN/apis/httpbin
    # Proxy abierto en /open
    http POST $ADMIN/apis name=httpbin uris=/open upstream_url=https://httpbin.org

- Restriccion por ACL
    # Crear un consumer
    http $ADMIN/consumers username=meetup

    # Crear endpoint `posters` (to be ACL'd)
    http POST $ADMIN/apis name=posters uris=/posters upstream_url=https://httpbin.org/post
    # Agregarle key-based auth
    http post $ADMIN/apis/posters/plugins name=key-auth config.key_names=apikey
    # Unauthorized :(
    http $PROXY/posters

    # Crearle API Key al consumer
    curl -X POST $ADMIN/consumers/meetup/key-auth -d ''
    # Authenticated call
    http post $PROXY/posters apikey:<apikey> foo=bar


Rate limiting por API
Rate limiting por consumer

Canary deploy
Datadog logging
