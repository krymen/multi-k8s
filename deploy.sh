docker build -t kmenzyk/multi-client:latest -t kmenzyk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kmenzyk/multi-server:latest -t kmenzyk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kmenzyk/multi-worker:latest -t kmenzyk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kmenzyk/multi-client:latest
docker push kmenzyk/multi-server:latest
docker push kmenzyk/multi-worker:latest

docker push kmenzyk/multi-client:$SHA
docker push kmenzyk/multi-server:$SHA
docker push kmenzyk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kmenzyk/multi-server:$SHA
kubectl set image deployments/client-deployment client=kmenzyk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kmenzyk/multi-worker:$SHA
