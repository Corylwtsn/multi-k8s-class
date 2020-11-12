docker build -t corylwtsn/multi-client:latest -t corylwtsn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t corylwtsn/multi-server:latest -t corylwtsn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t corylwtsn/multi-worker:latest -t corylwtsn/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push corylwtsn/multi-client:latest
docker push corylwtsn/mulit-server:latest
docker push corylwtsn/multi-worker:latest
docker push corylwtsn/multi-client:$SHA
docker push corylwtsn/mulit-server:$SHA
docker push corylwtsn/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=corylwtsn/multi-server:$SHA
kubectl set image deployments/client-deployment client=corylwtsn/multi-client:$SHA
kubectl set image deployments/worker-deployment woirker=corylwtsn/multi-worker:$SHA