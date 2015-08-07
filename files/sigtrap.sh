#!/bin/bash 

start_command="$1"
stop_command="$2"
state=running

function start {
  echo "$0 starting subprocess with '$start_command'"
  eval "$start_command"
  state=running
}

function shutdown {
  echo "$0 ending subprocess with '$stop_command'"
  echo "Should be shutting down"
  eval "$stop_command"
  state=shutdown
}

function restart { 
  echo "Should be restarting"
  $stop_command
  $start_command
}

trap shutdown SIGTERM SIGINT SIGQUIT

start
while [[ $state == 'running' ]]; do 
  sleep 1 &
  wait $!
done
