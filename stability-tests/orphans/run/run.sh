#!/bin/bash
rm -rf /tmp/karlsend-temp

karlsend --simnet --appdir=/tmp/karlsend-temp --profile=6061 &
KASPAD_PID=$!

sleep 1

orphans --simnet -alocalhost:42511 -n20 --profile=7000
TEST_EXIT_CODE=$?

kill $KASPAD_PID

wait $KASPAD_PID
KASPAD_EXIT_CODE=$?

echo "Exit code: $TEST_EXIT_CODE"
echo "Karlsend exit code: $KASPAD_EXIT_CODE"

if [ $TEST_EXIT_CODE -eq 0 ] && [ $KASPAD_EXIT_CODE -eq 0 ]; then
  echo "orphans test: PASSED"
  exit 0
fi
echo "orphans test: FAILED"
exit 1
