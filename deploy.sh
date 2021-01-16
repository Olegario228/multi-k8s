docker build -t jamiroquaixd/multi-client:latest -t jamiroquaixd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jamiroquaixd/multi-server:latest -t jamiroquaixd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jamiroquaixd/multi-worker:latest -t jamiroquaixd/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jamiroquaixd/multi-client:latest
docker push jamiroquaixd/multi-server:latest
docker push jamiroquaixd/multi-worker:latest
docker push jamiroquaixd/multi-client:$SHA
docker push jamiroquaixd/multi-server:$SHA
docker push jamiroquaixd/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jamiroquaixd/multi-server:$SHA
kubectl set image deployments/client-deployment client=jamiroquaixd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jamiroquaixd/multi-worker:$SHA