# Lab - Debugging on Kubernetes

In this lab, you will learn various techniques and commands on how to
debug an application running within Kubernetes.

As with any application, there are many many ways that things can go
wrong. There can be errors in the code, configuration, platform etc.
This lab will walk you through some common errors and the commands to
help you debug them.

You will be re-using the code in `lab-intro-to-kubernetes` from the
previous exercise.

## Debugging actions

### Show status of pods

To show an overview of the status of all pods, you can run:

``` bash
kubectl get pods -n NAMESPACE
```

This will output something like the following:

    NAME                        READY   STATUS    RESTARTS   AGE
    frontend-56c5d4bbb4-cjc74   1/1     Running   0          9m
    frontend-56c5d4bbb4-n6x9n   1/1     Running   0          9m
    frontend-56c5d4bbb4-r7rlt   1/1     Running   0          9m

Here you can often see issues when pods have a problem. This can present
itself as pods not showing as ready:

    READY
    0/1

A status that is not `RUNNING` (can show as a number of different error
statuses):

    STATUS
    Error

Or can show a high number of restarts.

    RESTARTS
    10

Any of the above symptoms can mean there is an issue with the pod that
needs further debugging.

### Show detail of a specific pod

If you find that a pod has a problem, you can dig deeper with the
following (replacing `POD_NAME` with the name of the pod):

``` bash
kubectl describe pod POD_NAME -n NAMESPACE
```

For example:

``` bash
kubectl describe pod frontend-56c5d4bbb4-cjc74 -n NAMESPACE
```

This gives a lot of useful information including a number of events
towards the bottom of the output. This is a good place to look if your
pod is having problems as the events often contain error messages that
can aid in debugging.

### Events

You can also look at all events within Kubernetes to try and ascertain
what might have happened.

``` bash
kubectl get events -n NAMESPACE
```

This can give fairly noisy output, depending on how long cluster has
been up and how many pods you have, but can often be helpful.

### Logging

As with any application, checking the logs when something goes wrong is
also a good place to look when debugging.

``` bash
kubectl logs POD_NAME -n NAMESPACE
```

E.g:

``` bash
kubectl logs frontend-56c5d4bbb4-cjc74 -n changeme
```

You can also add a `-f` option to follow the logs:

``` bash
kubectl logs -f POD_NAME -n NAMESPACE
```

One drawback of the default logging in Kubernetes is that there is no
built in log aggregation functionality. Therefore in a deployment with
multiple replicas, pods or containers you will need to tail logs of more
than one entity.

In larger installations, this can be tedious and complex if not
impossible, therefore a log aggregation solution is necessary. We will
discuss this further later in the course.

### Execute commands in the container

It can often be helpful to run a command inside a container. The syntax
for this is:

``` bash
kubectl exec -n NAMESPACE POD_NAME -- COMMAND
```

> Note: replace `POD_NAME` with the name of the pod you wish to execute
> within and `COMMAND` with the command to run.

You can also get an interactive shell on a container to allow you to
debug various elements within the container itself. This can involve
checking the environment variables, making sure all dependencies are
present, test the network, trying to run the start command manually to
see if you are able to get different or more verbose info from the
output streams, etc.

This is done with:

    kubectl exec -n NAMESPACE -it POD_NAME -- /bin/bash

## Exercise

> Note: replace all instances of `NAMESPACE` with your namespace, as
> recommended previously, this should be your Docker ID. Replace
> `DOCKER_ID` with your Docker Hub ID and `GITHUB_ID` with your GitHub
> ID.

Let's now intentionally break our application from
`lab-intro-to-kubernetes` and see what happens.

First of all, let's ensure that you only have one replica running:

``` bash
kubectl -n NAMESPACE get pods
```

This should return something like:

    NAME                               READY   STATUS    RESTARTS   AGE
    frontend-79c59bbc7f-d86hr          1/1     Running   0          3m

### Simulate error in Kubernetes config

Next, update the following line in
`lab-intro-to-kubernetes/kubernetes/deployment.yml`:

``` yaml
image: DOCKER_ID/lab-intro-to-kubernetes:0.0.2
```

This should have your Docker ID instead of `DOCKER_ID` initially. Change
your Docker ID to be `INVALID_ID` so that it looks like this:

``` yaml
image: INVALID_ID/lab-intro-to-kubernetes:0.0.2
```

When we apply this, it will create an error when trying to deploy (which
you will see when you later run `get pods`). Run:

``` bash
kubectl apply -n NAMESPACE -f kubernetes\
```

Then run the following again:

``` bash
kubectl -n NAMESPACE get pods
```

This time you will see something like this:

    NAME                               READY   STATUS             RESTARTS   AGE
    frontend-67f8d894bf-zgz7t          0/1     InvalidImageName   0          1m
    frontend-79c59bbc7f-d86hr          1/1     Running            0          13m

As expected you will see that the pod is showing that the image name you
have selected is invalid. Change the image name back to be your valid
Docker ID and run the apply command again:

``` bash
kubectl apply -n NAMESPACE -f kubernetes\
```

This should now look something like this:

    NAME                               READY   STATUS    RESTARTS   AGE
    frontend-79c59bbc7f-d86hr          1/1     Running   0          15m

### Simulate application error

Let's now create an error in the application. In
`lab-intro-to-kubernetes/scripts/docker-start.sh` change the line:

``` bash
flask run --host=0.0.0.0
```

To be:

``` bash
flask zrun --host=0.0.0.0
```

Now rebuild the application in Docker, push to DockerHub and deploy to
Kubernetes:

``` bash
docker build -t DOCKER_ID/lab-intro-to-kubernetes:0.0.3 .
docker push DOCKER_ID/lab-intro-to-kubernetes:0.0.3
kubectl -n NAMESPACE set image deployment/frontend kubernetes-intro-web=DOCKER_ID/lab-intro-to-kubernetes:0.0.3
```

Now, when we run:

``` bash
kubectl -n NAMESPACE get pods
```

We should see something like the following:

    NAME                       READY   STATUS        RESTARTS   AGE
    frontend-d4ddd8b99-5lfkc   0/1     Error         4          2m

As you will notice, we can see that the `STATUS` is `Error` or
`CrashLoopBackoff` and we have a number of `RESTARTS`. Depending on when
you submit the `get pods` command, you may also see the `READY` counter
show either `1/1` or `0/1`. This will depend on where in the container
launch cycle the process is. If you repeatedly submit the command, you
will see the `READY` count change. Either way, we can see there is a
problem with our app.

So let's now look at the description:

> You will need to replace the pod name with the one from your `get
> pods` output:

``` bash
kubectl -n NAMESPACE describe pod POD_NAME
```

At the bottom of the output, you will see something like this:

    Warning  BackOff                59s (x20 over 5m33s)   kubelet, ip-10-0-1-22.eu-west-1.compute.internal  Back-off restarting failed container

This indicates again that something is wrong with the container, but
isn't helping us to see exactly what. Let's now look at the logs for the
container:

``` bash
kubectl -n NAMESPACE logs POD_NAME
```

This will now show us the output from running the script:

    Creating a virtualenv for this project...
    Pipfile: /opt/hello_world/Pipfile
    Using /usr/bin/python (2.7.12) to create virtualenv...
    ⠏ Creating virtual environment...Already using interpreter /usr/bin/python
    New python executable in /root/.local/share/virtualenvs/hello_world-AVvKZXOc/bin/python
    Installing setuptools, pip, wheel...
    done.
    
    ✔ Successfully created virtual environment!
    Virtualenv location: /root/.local/share/virtualenvs/hello_world-AVvKZXOc
    Usage: flask [OPTIONS] COMMAND [ARGS]...
    Try "flask --help" for help.
    
    Error: No such command "zrun".

We can see that our typo has caused the problem.

Update the `lab-intro-to-kubernetes/docker-start.sh` file to once again
read:

``` bash
flask run --host=0.0.0.0
```

### Execute commands inside the container

To demonstrate debugging inside a container, let's now change the
`lab-intro-to-kubernetes/app.py`, update the following:

``` python
recipient = os.getenv("RECIPIENT", "world")
```

To be:

``` python
recipient = os.getenv("RECEIVER", "unknown")
```

Then build and deploy a new version:

``` bash
docker build -t DOCKER_ID/lab-intro-to-kubernetes:0.0.4 .
docker push DOCKER_ID/lab-intro-to-kubernetes:0.0.4
kubectl -n NAMESPACE set image deployment/frontend kubernetes-intro-web=DOCKER_ID/lab-intro-to-kubernetes:0.0.4
```

Once this has launched, you can navigate to the browser and see that it
shows `"unknown"`.

To have a look inside the container, get its name from `get pods`:

``` bash
kubectl -n NAMESPACE get pods
```

Then run:

``` bash
kubectl -n NAMESPACE exec -it POD_NAME -- /bin/bash
```

Which will give you a prompt like so:

``` shell
root@frontend-79c59bbc7f-mbf8s:/opt/hello_world#
```

Within the shell, you can now run any Linux command available in the
container. Let's have a look at the environment:

``` shell
env | sort
```

As you will see, there will be a lot of output, but our `RECEIVER`
variable won't be there (obviously, because we didn't set it). You can
now exit the container with:

``` shell
exit
```

Add the environment variable with:

``` bash
kubectl -n NAMESPACE set env deployment/frontend RECEIVER='myname'
```

Now you will see that the variable displays as `'myname'` in the
browser.
