#!/usr/bin/zsh

# Evie Development Script

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

message() {
    printf "$1 \n"
}

# Pull the latest changes from the repo
message "${RED}me: ${NC}@git pull!"
cd ./Evie && git pull --ff-only --force
message "${GREEN}git: ${NC}pulled it!"

# Install/Update dependencies
message "${RED}me: ${NC}@yarn update deps!"
yarn install
message "${BLUE}yarn: ${NC}done!"

# Compile the project
message "${RED}me: ${NC}@typescript compile!"
yarn build
message "${BLUE}typescript: ${NC}done!"

# Update the database schema
message "${RED}me: ${NC}@prisma db push!"
DATABASE_URL=postgresql://postgres:internalpassword@localhost:5432/bot?schema=public yarn pushdb

# Stop existing pm2 processes
message "${RED}me: ${NC}@pm2, stop!"
pm2 stop backend
pm2 stop park
message "${BLUE}pm2: ${NC}done!"

# Start new pm2 processes
message "${RED}me: ${NC}@pm2 start!"
doppler run -- pm2 start >/dev/null
message "${BLUE}pm2: ${NC}done!"
