export PATH

alias py="python"
alias composer="php -d memory_limit=-1 ~/.dotfiles/bin/composer"

# Symfony
alias sf='php bin/console --no-debug'
alias sfcl='sf cache:clear'
alias sfapc='sf apc:clear'
alias xpu='xolaphpunit'
alias flushlogs='cat /dev/null > var/logs/*.log;wc -l var/logs/*.log'

# run unit tests
function xolaphpunit() {
    vendor/phpunit/phpunit/phpunit -c phpunit.xml.dist --debug -d memory_limit=4096M "$@"
}

# Remove stuff from symfony's email spool
function clearspool() {
    rm -rf app/spool/default/
    mkdir -p app/spool/default/
    ls -a app/spool/default/
}

## NODEJS
alias nps="npm start"

alias npr="npm --silent run"
alias npmls="npm ls --depth=0"
alias npms="npm -w seller"
alias npmrs="npm --silent run -w seller"
alias npxs="npx -w seller"

function lint() {
    # Check if a file exists and is not empty
    FILE="./git_ignore/sanitize.sh"
    if [ -f "$FILE" ]; then
        $FILE
    else
        echo "File $FILE does not exist"
    fi
}

function getIpForEC2Instance() {
    aws --profile $1 ec2 describe-instances --instance-ids $2 --query 'Reservations[*].Instances[*].PublicIpAddress' --output text
}

function ec2() {
    # TODO: Keys & Profile
    ssh -i $1 ubuntu@$(getIpForEC2Instance $1 $2)
}
