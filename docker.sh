#!/bin/bash

build() {
    docker build -t journal:dev -f Dockerfile .
}

run() {
    docker run -it --rm \
        -p 8787:8787 \
        -v "$PWD/api/src:/app/api/src" \
        -v "$PWD/front/src:/app/front/src"  \
        -v "$PWD/socket/src:/app/socket/src" \
        --name cloudflare-dev \
        journal:dev \
        bash
}

shell() {
    docker exec -it cloudflare-dev /bin/bash
}



usage() {
    echo "Usage: $0 {build|run|shell}"
    echo
    echo "  build   - Builds the Docker image 'journal:dev' using the local Dockerfile"
    echo "  run     - Runs the 'journal:dev' container with source code mounted and opens a bash shell"
    echo "  shell   - Opens an interactive bash shell inside the running 'cloudflare-dev' container"
    echo
    exit 1
}

# Call the appropriate function based on the argument
case "$1" in
    build)
        build
        ;;
    run)
        run
        ;;
    shell)
        shell
        ;;
    *)
        usage
        ;;
esac