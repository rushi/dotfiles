#!/bin/bash

export PATH

alias py="python"
alias composer="php -d memory_limit=-1 ~/.dotfiles/bin/composer"

# Symfony
alias sf='php bin/console --no-debug'
alias sfcl='sf cache:clear'
alias sfapc='sf apc:clear'
alias xpu='APP_ENV=test xolaphpunit'
alias flushlogs='cat /dev/null > var/log/*.log;wc -l var/log/*.log'

# run unit tests
function xolaphpunit() {
    APP_ENV=test
    echo 'Running APP_ENV=test vendor/phpunit/phpunit/phpunit -c phpunit.xml.dist -v -d memory_limit=4096M "$@"'
    vendor/phpunit/phpunit/phpunit -c phpunit.xml.dist -v -d memory_limit=4096M "$@"
}

# Remove stuff from symfony's email spool
function clearspool() {
    # echo "I think this wont work after changing to symfony 4";
    rm -rf var/spool/default/
    mkdir -p var/spool/default/
    ls -a var/spool/default/
}

function lint() {
    # Check if a file exists and is not empty
    FILE="./git_ignore/sanitize.sh"
    if [ -f "$FILE" ]; then
        $FILE
    else
        # echo "File $FILE does not exist. Running npm run lint:fix"
        npm run --if-present lint
        npm run --if-present typecheck
    fi
}

# function getIpForEC2Instance() {
#     aws --profile $1 ec2 describe-instances --instance-ids $2 --query 'Reservations[*].Instances[*].PublicIpAddress' --output text
# }

# function ec2() {
#     # TODO: Keys & Profile
#     ssh -i $1 ubuntu@$(getIpForEC2Instance $1 $2)
# }

##
## NODEJS
##

function init_npm() {
    zx ./initNodeProject.mjs
}

function npm_start() {
    if [ ! -f "./package.json" ]; then
        chalk -t 'Cannot start {red.bold ./package.json} does not exist in the current directory.'
        return
    fi

    npm start "$@"
}

function npm_dev() {
    if [ ! -f "./package.json" ]; then
        chalk -t 'Cannot run dev {red.bold ./package.json} does not exist in the current directory.'
        return
    fi

    npm run dev "$@"
}

function npm_test() {
    if [ ! -f "./package.json" ]; then
        chalk -t 'Cannot run dev {red.bold ./package.json} does not exist in the current directory.'
        return
    fi

    npm run test --if-present "$@"
}

alias s="npm_start"
alias dev="npm_dev"
alias test="npm_test"
alias npr="npm --silent run"
alias npmls="npm ls --depth=0"

function switch_env() {
    env=$1
    if [ -z "$env" ]; then
        chalk -t '{red No environment specified. Usage: switch_config <env>}'
        return
    fi

    # Check if $env.json exists
    if [ ! -f "./config/$env.json" ]; then
        chalk -t "{red Config file does not exist: ./config/$env.json}"
        return
    fi

    # Switch the environment
    cd config || exit 0
    ln -fs "local-$env.json" "local-development.json"
    cat local-development.json | jq .
    chalk -t "Switched to {green $env} environment"
    cd ..
}
