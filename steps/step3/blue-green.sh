#!/bin/bash

echo "Starting deploy green deployment....."

kubectl apply -f index_green_html.yml
kubectl apply -f green.yml

ATTEMPTS=0
ROLLOUT_STATUS_CMD="kubectl -n udacity rollout status deployment/green | grep successfully"

until $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 60 ]; do
    $ROLLOUT_STATUS_CMD
    ATTEMPTS=$((attempts + 1))

    sleep 1
done


echo "Cleaning blue resources......"
kubectl -n udacity delete deployment blue
kubectl -n udacity delete svc blue
echo "Done cleaning blue resources!"

echo "Blue-green deployment of replicas successful!"