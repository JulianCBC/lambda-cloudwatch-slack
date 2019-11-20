set -x

pact-mock-service start -p 9000 --ssl

export UNENCRYPTED_HOOK_URL="https://localhost:9000/"
export NODE_TLS_REJECT_UNAUTHORIZED=0

for i in test/*.test.json; do
	echo "Testing $i ..."
	node-lambda run -x test/context.json -j $i
	echo
done

pact-mock-service stop -p 9000
