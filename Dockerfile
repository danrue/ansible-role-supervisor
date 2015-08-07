FROM ansible/ubuntu14.04-ansible:devel
MAINTAINER acyost@spscommerce.com
ADD . /tmp/ansible-role-supervisor
WORKDIR /tmp/ansible-role-supervisor
ENV ANSIBLE_FORCE_COLOR=true
ENV PYTHONUNBUFFERED=1

## run tests

## example program starts automatically w/ supervisor service
RUN ansible-playbook -i "[test] localhost," -c local tests/test_autostart.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_autostart.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test(autostart): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(autostart): \033[0;31mfail\033[0m' && exit 1) 

## starting example program w/ supervisorctl module ( ansible ) works correctly
RUN ansible-playbook -i "[test] localhost," -c local tests/test_stop_mod.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_stop_mod.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test(modstop): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(modstop): \033[0;31mfail\033[0m' && exit 1)

## stopping example program w/ supervisorctl module ( ansible ) works correctly
RUN ansible-playbook -i "[test] localhost," -c local tests/test_start_mod.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_start_mod.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test(modstart): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(modstart): \033[0;31mfail\033[0m' && exit 1)

## stopping example program w/ command module works ( caveats )
RUN ansible-playbook -i "[test] localhost," -c local tests/test_stop.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_stop.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test(stop): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(stop): \033[0;31mfail\033[0m' && exit 1) 

## starting example program w/ command module works
RUN ansible-playbook -i "[test] localhost," -c local tests/test_start.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_start.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test(start): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(start): \033[0;31mfail\033[0m' && exit 1) 



## all the things in one context
RUN ansible-playbook -i "[test] localhost," -c local tests/test_autostart.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_autostart.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test(autostart): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(autostart): \033[0;31mfail\033[0m' && exit 1) &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_stop_mod.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_stop_mod.yml 2>/dev/null | grep -q 'changed=0.*failed=0'  &&\
    (echo 'Idempotence test(modstop): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(modstop): \033[0;31mfail\033[0m' && exit 1) &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_start_mod.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_start_mod.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test(modstart): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(modstart): \033[0;31mfail\033[0m' && exit 1) &&\
    ansible-playbook -vvvv -i "[test] localhost," -c local tests/test_stop.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_stop.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test(stop): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(stop): \033[0;31mfail\033[0m' && exit 1) &&\
    ansible-playbook -vvvv -i "[test] localhost," -c local tests/test_start.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests/test_start.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test(start): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(start): \033[0;31mfail\033[0m' && exit 1)

CMD /bin/bash
