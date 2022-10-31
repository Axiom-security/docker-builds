set -e

if [ -z $TAG ]
then
  echo "need to specify tag as a parameter"
  exit 1
fi

docker build . -f auto-setup.Dockerfile -t temporal-auto-setup/auto-setup:$TAG --no-cache