# Take the base Pytorch Container
# docker build -f Dockerfile -t inf .
# docker tag inf:latest 952972464070.dkr.ecr.us-east-1.amazonaws.com/inf:latest
# docker push 952972464070.dkr.ecr.us-east-1.amazonaws.com/inf:latest

FROM amazonlinux:2

RUN yum install -y awscli

RUN yum install -y java-1.8.0-openjdk
COPY build/libs/*.jar app.jar
COPY al2/libneuron_op.so /lib/libneuron_op.so
ENV PYTORCH_EXTRA_LIBRARY_PATH=/lib/libneuron_op.so
EXPOSE 8080

RUN yum install -y python3
RUN yum install -y pip
RUN pip3 install boto3
RUN yum install -y procps
RUN echo $'[neuron] \n\
name=Neuron YUM Repository \n\
baseurl=https://yum.repos.neuron.amazonaws.com \n\
enabled=1' > /etc/yum.repos.d/neuron.repo
RUN rpm --import https://yum.repos.neuron.amazonaws.com/GPG-PUB-KEY-AMAZON-AWS-NEURON.PUB
COPY neuron-rtd/monitor.conf /opt/aws/neuron/config/monitor.conf
RUN yum install -y aws-neuron-tools
RUN yum install -y tar gzip
ENV PATH="/opt/aws/neuron/bin:${PATH}"

ENTRYPOINT ["java", "-Xms4096m", "-Xmx4096m", "-jar", "/app.jar"]