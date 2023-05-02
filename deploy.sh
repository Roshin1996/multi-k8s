docker build -t roshin1996/multi-client:latest -t roshin1996/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t roshin1996/multi-server:latest -t roshin1996/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t roshin1996/multi-worker:latest -t roshin1996/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push roshin1996/multi-client:latest
docker push roshin1996/multi-server:latest
docker push roshin1996/multi-worker:latest
docker push roshin1996/multi-client:$SHA
docker push roshin1996/multi-server:$SHA
docker push roshin1996/multi-worker:$SHA

kubectl apply -f ./k8s/

kubectl set image deployments/server-deployment server=roshin1996/multi-server:$SHA
kubectl set image deployments/client-deployment client=roshin1996/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=roshin1996/multi-worker:$SHA