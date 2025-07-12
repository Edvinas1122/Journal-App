#!/bin/bash

com_dir=utils/command/local/

build() {
    bash "$com_dir/build.sh"
}

run() {
    bash "$com_dir/run.sh"
}

tunnel () {
    bash "utils/command/tunnel.sh"
}

end() {
    bash "$com_dir/end.sh"
}

setup() {
    SCRIPT_PATH="$(realpath "$0")"
    ALIAS_CMD="alias app=\"$SCRIPT_PATH\""

    # Detect shell and config file
    SHELL_NAME=$(basename "$SHELL")
    case "$SHELL_NAME" in
        bash)
            CONFIG_FILE="$HOME/.bashrc"
            ;;
        zsh)
            CONFIG_FILE="$HOME/.zshrc"
            ;;
        *)
            echo "Unsupported shell: $SHELL_NAME"
            echo "Add this line manually to your shell config:"
            echo "$ALIAS_CMD"
            return
            ;;
    esac

    # Add alias if not already present
    if ! grep -Fxq "$ALIAS_CMD" "$CONFIG_FILE"; then
        echo "$ALIAS_CMD" >> "$CONFIG_FILE"
        echo "Alias 'app' added to $CONFIG_FILE"
        echo "Run 'source $CONFIG_FILE' or restart your terminal to use 'app'"
    else
        echo "Alias 'app' already exists in $CONFIG_FILE"
    fi
}

usage() {
    echo "Usage: $0 {build|run|tunnel|end|setup}"
    echo
    echo "  build   - Installs dependencies and sets up Node.js instances (runs build.sh)"
    echo "  run     - Starts the local development environment (runs run.sh)"
    echo "  tunnel  - Creates a secure tunnel (runs tunnel.sh)"
    echo "  end     - Stops the environment and performs cleanup (runs end.sh)"
    echo "  setup   - Adds an alias 'app' pointing to this script in your shell config"
    echo
    exit 1
}

case "$1" in
    build)
        build
        ;;
    run)
        run
        ;;
    tunnel)
        tunnel
        ;;
    end)
        end
        ;;
    setup)
        setup
        ;;
    *)
        usage
        ;;
esac
