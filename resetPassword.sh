#!/bin/bash

# Password Reset Helper Script for Gainium Self-Hosted
# Usage: ./resetPassword.sh <username> <newPassword>
# Example: ./resetPassword.sh admin MyNewPass123

set -e

if [ $# -lt 2 ]; then
    echo "Usage: ./resetPassword.sh <username> <newPassword>"
    echo ""
    echo "Password requirements:"
    echo "  - At least 6 characters"
    echo "  - At least one uppercase letter"
    echo "  - At least one lowercase letter"
    echo "  - At least one digit"
    echo ""
    echo "Example:"
    echo "  ./resetPassword.sh admin MyNewPass123"
    exit 1
fi

USERNAME="$1"
PASSWORD="$2"

echo "🔐 Resetting password for user: $USERNAME"
echo "This will connect to MongoDB and update the user password."
echo ""

# Run the CLI command in the container
docker-compose run --rm cli-runner npm run cli:reset-password -- "$USERNAME" "$PASSWORD"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Password reset completed successfully!"
else
    echo ""
    echo "❌ Password reset failed. Please check the error message above."
    exit 1
fi
