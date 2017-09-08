#!/bin/bash

function make_dockerfile(){
    cat > Dockerfile <<EOF
FROM python:3.6-alpine
RUN pip3 install flask
ADD api.py /data/api.py
ENTRYPOINT ["python3"]
CMD ["/data/api.py"]
EOF
}

for V in $(find . -type d -not -path . -print | cut -c 3-); do
    pushd $V
    make_dockerfile
    IMAGE="nicovillanueva/kong-demoapi:$V"
    docker build -t $IMAGE .
    docker push $IMAGE
    rm Dockerfile
    popd
done
