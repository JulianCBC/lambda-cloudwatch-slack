set -x

pact-mock-service start -p 9000 --ssl

export UNENCRYPTED_HOOK_URL="https://localhost:9000/"
export NODE_TLS_REJECT_UNAUTHORIZED=0

node-lambda run -x test/context.json -j test/sns-codepipeline-event-pipeline-started.json
node-lambda run -x test/context.json -j test/sns-codepipeline-event-stage-started.json
node-lambda run -x test/context.json -j test/sns-codepipeline-event-stage-succeeded.json
node-lambda run -x test/context.json -j test/sns-codepipeline-event-stage-failed.json
node-lambda run -x test/context.json -j test/sns-cloudwatch-event.json
node-lambda run -x test/context.json -j test/sns-event.json
node-lambda run -x test/context.json -j test/sns-elastic-beanstalk-event.json
node-lambda run -x test/context.json -j test/sns-codedeploy-event.json
node-lambda run -x test/context.json -j test/sns-codedeploy-configuration.json
node-lambda run -x test/context.json -j test/sns-elasticache-event.json
node-lambda run -x test/context.json -j test/sns-autoscaling-event.json

pact-mock-service stop -p 9000
