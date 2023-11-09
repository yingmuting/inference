## Take the base Pytorch Container
## docker build -f Dockerfile -t infgv2 .
## docker tag infgv2:latest 952972464070.dkr.ecr.us-east-1.amazonaws.com/infgv2:latest
## docker push 952972464070.dkr.ecr.us-east-1.amazonaws.com/infgv2:latest
## docker buildx build --platform linux/arm64 --tag 952972464070.dkr.ecr.us-east-1.amazonaws.com/infgv2:latest --push .
#
#FROM arm64v8/openjdk:8
#COPY *.jar app.jar
## COPY al2/bak_libneuron_op.so /lib/bak_libneuron_op.so
## ENV PYTORCH_EXTRA_LIBRARY_PATH=/lib/bak_libneuron_op.so
#EXPOSE 8081
#ENTRYPOINT ["java", "-jar", "/app.jar"]

# Take the base Pytorch Container
# docker build -f Dockerfile -t infc5 .
# docker tag infc5:latest 952972464070.dkr.ecr.us-east-1.amazonaws.com/infc5:latest
# docker push 952972464070.dkr.ecr.us-east-1.amazonaws.com/infc5:latest

FROM openjdk:8

COPY *.jar app.jar
#COPY al2/bak_libneuron_op.so /lib/bak_libneuron_op.so
#ENV PYTORCH_EXTRA_LIBRARY_PATH=/lib/bak_libneuron_op.so
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/app.jar"]