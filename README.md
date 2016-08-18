# RHEL72Draios

The following is a Dockerfile and script(s) to build the Sysdig Draios agent.

Clone the github repo, on a RHEL7 host with Docker installed

Build the container - docker build -t rhel7/draios .

There is a script included with it - agent-sysdig-run.sh

docker run --name rhel7sysdig-agent --privileged --net host --pid host -e ACCESS_KEY=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx -e TAGS=role:glen_test,location:01886 -v /var/run/docker.sock:/host/var/run/docker.sock -v /dev:/host/dev -v /proc:/host/proc:ro -v /boot:/host/boot:ro -v /lib/modules:/host/lib/modules:ro -v /usr:/host/usr:ro rhel7/draios

In the script, you would replace the value of ACCESS_KEY=xxxxxx with your own - sign up for Sysdig cloud monitoring at http://sysdig.com

Once you have done this, save the script and run it

./agent-sysdig-run.sh

