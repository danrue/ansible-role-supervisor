FROM ansible/ubuntu14.04-ansible:devel
MAINTAINER acyost@spscommerce.com
ADD . /tmp/ansible-role-supervisor
## IGNORE THE HAND WAVING HUMAN
ADD . /tmp/ansible-role-supervisor/roles/ansible-role-supervisor
WORKDIR /tmp/ansible-role-supervisor
ENV ANSIBLE_FORCE_COLOR=true
ENV PYTHONUNBUFFERED=1

## run tests
RUN ansible-playbook -i "[test] localhost," -c local test.yml &&\
    ansible-playbook -i "[test] localhost," -c local test.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test: \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test: \033[0;31mfail\033[0m' && exit 1) 

CMD /bin/bash
