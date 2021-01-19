docker build -t erviveksoni/multi-client:latest -t erviveksoni/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t erviveksoni/multi-server:latest -t erviveksoni/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t erviveksoni/multi-worker:latest -t erviveksoni/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push erviveksoni/multi-client:latest
docker push erviveksoni/multi-client:$SHA
docker push erviveksoni/multi-server:latest
docker push erviveksoni/multi-server:$SHA
docker push erviveksoni/multi-worker:latest
docker push erviveksoni/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=erviveksoni/multi-client:$SHA
kubectl set image deployments/server-deployment server=erviveksoni/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=erviveksoni/multi-worker:$SHA