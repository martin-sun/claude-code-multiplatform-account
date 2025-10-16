#!/bin/bash

# ============================================
# Claude Code Multi-Service Launcher
# ============================================
# Start Claude Code with different API providers

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to get service description
get_service_description() {
    case "$1" in
        kimi)
            echo "Kimi K2 (Moonshot AI)"
            ;;
        glm)
            echo "GLM-4.5 (Z.AI)"
            ;;
        default)
            echo "Claude (Official Anthropic)"
            ;;
        *)
            echo "Unknown"
            ;;
    esac
}

# Function to display menu
show_menu() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}  Claude Code Service Launcher${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    echo "Select a service to start:"
    echo ""
    echo "  1) Kimi K2 (Moonshot AI)"
    echo "  2) GLM-4.5 (Z.AI)"
    echo "  3) Claude (Official Anthropic)"
    echo "  4) Exit"
    echo ""
    echo -n "Enter your choice [1-4]: "
}

# Function to validate service
is_valid_service() {
    case "$1" in
        kimi|glm|default)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Function to start service
start_service() {
    local service=$1
    local service_dir="${SCRIPT_DIR}/claude-${service}"

    if [ ! -d "$service_dir" ]; then
        echo -e "${YELLOW}Error: Service directory not found: $service_dir${NC}"
        exit 1
    fi

    if [ ! -f "$service_dir/.env" ]; then
        echo -e "${YELLOW}Warning: .env file not found in $service_dir${NC}"
        echo "Please copy .env.example to .env and configure it first:"
        echo "  cd $service_dir"
        echo "  cp .env.example .env"
        echo "  # Edit .env with your API key"
        exit 1
    fi

    echo ""
    echo -e "${GREEN}Starting $(get_service_description "$service")...${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""

    cd "$service_dir"
    docker compose run --rm -it claude
}

# Main logic
main() {
    # Check if service is provided as argument
    if [ $# -eq 1 ]; then
        service=$1
        if ! is_valid_service "$service"; then
            echo -e "${YELLOW}Error: Unknown service '$service'${NC}"
            echo "Available services: kimi, glm, default"
            exit 1
        fi
        start_service "$service"
        exit 0
    fi

    # Interactive menu
    while true; do
        show_menu
        read choice

        case $choice in
            1)
                start_service "kimi"
                break
                ;;
            2)
                start_service "glm"
                break
                ;;
            3)
                start_service "default"
                break
                ;;
            4)
                echo ""
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo -e "${YELLOW}Invalid choice. Please select 1-4.${NC}"
                sleep 1
                ;;
        esac
    done
}

# Run main function
main "$@"
