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
    echo 'Running vendor/phpunit/phpunit/phpunit -c phpunit.xml.dist -v -d memory_limit=4096M "$@"'
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
        echo "File $FILE does not exist. Running npm run lint:fix"
        npm run lint:fix
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

function uikit() {
    if [ ! -f "./package.json" ]; then
        chalk -t 'Cannot install UI Kit. {red.bold ./package.json} does not exist in the current directory.'
        return
    fi

    rg --quiet workspaces package.json
    if [[ $? -eq 0 ]]; then
        chalk -t 'This is an {red.bold npm workspace}, you probably do not want to install UI Kit here'
        bat package.json
        return
    fi

    if [ -z "$1" ]; then
        chalk -t 'Installing {green @xola/ui-kit@latest} from NPM'
        npm install @xola/ui-kit@latest --save
    elif [[ -n "$1" && -n "$2" ]]; then
        # npm install https://github.com/rushi/ui-kit\#react-upgrade --save
        chalk -t "Installing from {bold Github} {green $1/ui-kit Branch: $2}"
        npm install "https://github.com/$1/ui-kit\#$2" --save
    else
        chalk -t 'Installing {green $1} from NPM'
        npm install "$1" --save
    fi
}
alias ui-kit="uikit"

function npm_start() {
    if [ ! -f "./package.json" ]; then
        chalk -t 'Cannot start {red.bold ./package.json} does not exist in the current directory.'
        return
    fi

    npm start
}

function npm_dev() {
    if [ ! -f "./package.json" ]; then
        chalk -t 'Cannot run dev {red.bold ./package.json} does not exist in the current directory.'
        return
    fi

    npm run dev
}

alias s="npm_start"
alias dev="npm_dev"
alias npr="npm --silent run"
alias npmls="npm ls --depth=0"
