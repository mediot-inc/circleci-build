
FROM --platform=linux/amd64 cimg/base:2021.04 AS aws
ENV DEBIAN_FRONTEND=noninteractive
RUN sudo apt-get update && sudo apt-get install python3-venv
ADD https://s3.amazonaws.com/aws-cli/awscli-bundle-1.18.223.zip awscli-bundle.zip
RUN cd /usr/bin && sudo ln -s pydoc3 pydoc && sudo ln -s python3 python
RUN sudo unzip awscli-bundle.zip \
   && sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

FROM --platform=linux/amd64 cimg/base:2021.04 AS terraform
ADD https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip terraform.zip
RUN sudo unzip terraform.zip


FROM --platform=linux/amd64 cimg/base:2021.04
# aws
RUN cd /usr/bin && sudo ln -s pydoc3 pydoc && sudo ln -s python3 python
COPY --from=aws /usr/local/aws /usr/local/aws/
RUN sudo ln -s /usr/local/aws/bin/aws /usr/local/bin/aws
# terraform
COPY --from=terraform /home/circleci/project/terraform /bin/
# other dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN sudo apt-get update && sudo apt-get install -y groff mime-support
ENV DEBIAN_FRONTEND=newt
