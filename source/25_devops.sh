function slsdeploy() {
    set -x
    npx serverless deploy --stage=$1 --env=$1 --secretsFile=config/local-$1.json
    set +x
}

# TODO: ec2 start <instance-id>
# TODO: ec2 start router-01
# TODO: ec2 start router-01.xola.com
# TODO: Show, Stop, Restart

# {
#   "Changes": [
#     {
#       "Action": "UPSERT",
#       "ResourceRecordSet": {
#         "Name": "<DomainName>",
#         "Type": "A",
#         "TTL": 300,
#         "ResourceRecords": [
#           {
#             "Value": "<NewIP>"
#           }
#         ]
#       }
#     }
#   ]
# }

function foo() {
    ZONE_NAME=$1
    RECORD_NAME=$2
    RECORD_TYPE=$3
    IP_ADDRESS=$4

    ZONE_ID=$(aws route53 list-hosted-zones --query "HostedZones[?Name == '${ZONE_NAME}.'].Id" --output text)

    if [ -z "$ZONE_ID" ]; then
        echo "Zone ID not found for ${ZONE_NAME}"
        exit 1
    fi

    CHANGE_BATCH=$(
        cat <<EOF
{
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "${RECORD_NAME}",
        "Type": "${RECORD_TYPE}",
        "TTL": 300,
        "ResourceRecords": [
          {
            "Value": "${IP_ADDRESS}"
          }
        ]
      }
    }
  ]
}
EOF
    )

    aws route53 change-resource-record-sets --hosted-zone-id "${ZONE_ID}" --change-batch "${CHANGE_BATCH}"

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
