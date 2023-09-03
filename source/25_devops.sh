function slsdeploy() {
    set -x
    npx serverless deploy --stage=$1 --env=$1 --secretsFile=config/local-$1.json
    set +x
}

function getIpForEC2Instance() {
    aws --profile $1 ec2 describe-instances --instance-ids $2 --query 'Reservations[*].Instances[*].PublicIpAddress' --output text
}

function ec2Test() {
    IP=$(getIpForEC2Instance xola-ci $1)
    ssh -i ~/.ssh/keys/test-servers.pem ubuntu@$IP
}

um()
{
    glow ~/.dotfiles/umm/*$1*.md
}

umm()
{
    glow ~/.dotfiles/umm/*$1*.md
}
