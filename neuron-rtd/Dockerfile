# To build:
# docker build -f Dockerfile -t test_neuron_rtd .
# docker tag test_neuron_rtd:latest 952972464070.dkr.ecr.us-east-1.amazonaws.com/test_neuron_rtd:1.0.0
# docker push 952972464070.dkr.ecr.us-east-1.amazonaws.com/test_neuron_rtd:1.0.0

# FROM 790709498068.dkr.ecr.us-west-2.amazonaws.com/neuron-rtd:1.0.6905.0
FROM amazonlinux:2

RUN yum install -y python3
RUN yum install -y pip
RUN pip3 install boto3
RUN yum install -y procps
RUN yum install -y net-tools
RUN yum install -y pciutils

RUN echo $'[neuron] \n\
name=Neuron YUM Repository \n\
baseurl=https://yum.repos.neuron.amazonaws.com \n\
enabled=1' > /etc/yum.repos.d/neuron.repo
RUN rpm --import https://yum.repos.neuron.amazonaws.com/GPG-PUB-KEY-AMAZON-AWS-NEURON.PUB

COPY monitor.conf /opt/aws/neuron/config/monitor.conf
RUN yum install -y aws-neuron-dkms
RUN yum install -y aws-neuron-runtime-base
RUN yum install -y aws-neuron-runtime
RUN yum install -y aws-neuron-tools
RUN yum install -y tar gzip
ENV PATH="/opt/aws/neuron/bin:${PATH}"
CMD neuron-rtd -g unix:/sock/neuron.sock -x