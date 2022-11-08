set -e

TAG=$1
ENVIRONMENT=$2
SERVER_IMAGE=$3

BASE=708482085879.dkr.ecr.eu-central-1.amazonaws.com/temporal-auto-setup

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



aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 708482085879.dkr.ecr.eu-central-1.amazonaws.com
docker build --platform linux/$PLATFORM -f auto-setup.Dockerfile --build-arg SERVER_IMAGE=$SERVER_IMAGE  -t $BASE:$TAG .
docker $BASE:$TAG