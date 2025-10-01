# start jupyter-pyspark container
container run -d --name jupyter-pyspark --rm -p 8888:8888 -p 4040:4040 \
    -v $(pwd)/jupyter:/home/jovyan/work \
    -e CHOWN_EXTRA="/home/jovyan/work" \
    -e CHOWN_EXTRA_OPTS="-R" \
    quay.io/jupyter/pyspark-notebook:aarch64-spark-3.5.3

# wait until the container has started
sleep 3

# run setup commands
container exec jupyter-pyspark mkdir /tmp/spark-events
container exec jupyter-pyspark chmod -R go+rwx /tmp/spark-events

# wait until the folders are created and configured
sleep 2

# show logs
container logs -f jupyter-pyspark