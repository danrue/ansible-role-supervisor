FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER aherrera@spscommerce.com
ADD ./tests /tmp/playbook
WORKDIR /tmp/playbook
ENV ANSIBLE_FORCE_COLOR=true
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
vim \
python-pip \
python-dev \
build-essential

## run tests
RUN ansible-playbook -vvvv -i "[test] localhost," -c local tests.yml -e "environ=dev" &&\
    ansible-playbook -i "[test] localhost," -c local tests.yml -e "environ=dev" 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test: \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test: \033[0;31mfail\033[0m' && exit 1)

EXPOSE 22 
CMD ["/usr/sbin/sshd", "-D"]
