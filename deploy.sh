docker build -t shermanng10/multi-client:latest -t shermanng10/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shermanng10/multi-server:latest -t shermanng10/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shermanng10/multi-worker:latest -t shermanng10/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shermanng10/multi-client:latest
docker push shermanng10/multi-server:latest
docker push shermanng10/multi-worker:latest

docker push shermanng10/multi-client:$SHA
docker push shermanng10/multi-server:$SHA
docker push shermanng10/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=shermanng10/multi-server:$SHA
kubectl set image deployments/server-deployment server=shermanng10/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=shermanng10/multi-server:$SHA
