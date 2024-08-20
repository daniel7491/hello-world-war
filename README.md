Hello World! (WAR-style)
===============

This is the simplest possible Java webapp for testing servlet container deployments.  It should work on any container and requires no other dependencies or configuration.


how to run: 
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
and the app is reachable at http://3.96.128.151:30007/hello-world-war-1.0.0/