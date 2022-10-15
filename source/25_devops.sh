function slsdeploy() {
    set -x
    npx serverless deploy --stage=$1 --env=$1 --secretsFile=config/local-$1.json
    set +x
}

function getIpForEC2Instance() {
    aws --profile $1 ec2 describe-instances --instance-ids $2 --query 'Reservations[*].Instances[*].PublicIpAddress' --output text
}

function ec2() {
    # TODO: Keys & Profile
    ssh -i $1 ubuntu@$(getIpForEC2Instance $1 $2)
}
