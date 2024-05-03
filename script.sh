#!/bin/bash

read -p "Enter project pathname (e.g., /path/to/project-name): " project_path

project_name=ts-project-setup

gitignore_path="$(pwd)/$project_name/.gitignore"
tsconfig_path="$(pwd)/$project_name/tsconfig.json"
eslint_path="$(pwd)/$project_name/eslint.config.js"  
npm_scripts_path="$(pwd)/$project_name/scripts.txt"

if [ -d "$project_path" ]; then
    read -p "The directory $project_path already exists. Do you want to delete it and recreate it? (y/n) " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        rm -rf "$project_path"
    else
        echo "Operation cancelled."
        exit 1
    fi
fi

mkdir -p "$project_path"
cd "$project_path" || exit  

npm init -y

npm install -D typescript eslint @eslint/js typescript-eslint nodemon ts-node @types/node

mkdir src
echo 'console.log("Hello, TypeScript!");' > src/index.ts

git init

cp "$gitignore_path" ./.gitignore  
cp "$tsconfig_path" ./tsconfig.json 
cp "$eslint_path" ./eslint.config.js

git add .  > /dev/null 2>&1
git commit -m "feature: init"  > /dev/null 2>&1

echo "Project setup complete. Navigate to $project_path to start working."
echo "Suggestion for npm scripts:"
cat $npm_scripts_path

