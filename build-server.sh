set -e

# need both of these projects. uncomment on CI/CD systems
# git clone git@github.com:temporalio/temporal.git
# git clone git@github.com:temporalio/tctl.git
# /etc/temporal

rm -rf temporal
rm -rf tctl

cp -r ../temporal .
cp -r ../tctl .

mkdir -p temporal/axiom
cp -r ../axiom/* temporal/axiom

TAG=$1
if [ -z $TAG ]
then
  echo "need to specify tag as a parameter"
  exit 1
fi

docker build . -f server.Dockerfile -t temporal-server/server:$TAG --no-cache