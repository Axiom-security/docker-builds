set -e

TAG=$1
ENVIRONMENT=$2
SERVER_IMAGE=$3

if [ -z $TAG ]
then
  echo "need to specify tag as a parameter"
  exit 1
fi

if [ -z $ENVIRONMENT ]
then
  echo "need to specify environment to build on as a parameter. values are local or cluster"
  exit 1
fi

if [ $ENVIRONMENT == "local" ]
then
  PLATFORM=arm64
else
  PLATFORM=amd64
fi

docker build --platform linux/$PLATFORM -f auto-setup.Dockerfile --build-arg SERVER_IMAGE=$SERVER_IMAGE  -t 983604318039.dkr.ecr.eu-central-1.amazonaws.com/temporal-auto-setup:$TAG .