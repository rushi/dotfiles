function slsdeploy() {
    set -x
    npx serverless deploy --stage=$1 --env=$1 --secretsFile=config/local-$1.json
    set +x
}

function ec2_id() {
    # aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].{InstanceId:InstanceId,PublicIpAddress:PublicIpAddress,State:State.Name,Name:Tags[?Key=='Name']}"
    aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --query "Reservations[*].Instances[*].{Name:Tags[?Key=='Name'],InstanceId:InstanceId,PublicIpAddress:PublicIpAddress,State:State.Name}" | jq '.'
}

function ec2_start() {
    aws ec2 start-instances --instance-ids "$1" | jq '.'
}

function ec2_stop() {
    aws ec2 stop-instances --instance-ids "$1" | jq '.'
}

function ec2_reboot() {
    aws ec2 reboot-instances --instance-ids "$1" | jq '.'
}

function getIpForEC2Instance() {
    aws --profile "$1" ec2 describe-instances --instance-ids $2 --query 'Reservations[*].Instances[*].PublicIpAddress' --output text
}

function ec2Test() {
    IP=$(getIpForEC2Instance xola-ci $1)
    ssh -i ~/.ssh/keys/test-servers.pem ubuntu@$IP
}

um() {
    glow ~/.dotfiles/umm/*$1*.md
}

umm() {
    glow ~/.dotfiles/umm/*$1*.md
}

alias d="docker"
alias dr="docker run --rm"
alias dc="docker compose"
alias ag="echo 'Using rg instead';rg"
