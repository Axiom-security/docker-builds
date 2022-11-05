set -e

# need both of these projects. uncomment on CI/CD systems
# git clone git@github.com:Axiom-security/temporal.git
# git clone git@github.com:temporalio/tctl.git
# /etc/temporal

rm -rf temporal
rm -rf tctl

cp -r ../temporal .
cp -r ../tctl .

mkdir -p temporal/axiom
cp -r ../axiom/* temporal/axiom

BASE=983604318039.dkr.ecr.eu-central-1.amazonaws.com/temporal-server
TAG=$1
ENVIRONMENT=$2

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

docker build -f server.Dockerfile --platform linux/$PLATFORM -t $BASE:$TAG .