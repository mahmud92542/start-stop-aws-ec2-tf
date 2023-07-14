import boto3

region = 'ap-southeast-1'
# instance IDs involved in the operation
instances = ['']
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    if 'operation' in event:
        if event['operation'] == 'start':
            ec2.start_instances(InstanceIds=instances)
            print('started your instances: ' + str(instances))
        elif event['operation'] == 'stop':
            ec2.stop_instances(InstanceIds=instances)
            print('stopped your instances: ' + str(instances))
        else:
            print('No operation matched')
    else:
        print('No operation detected')
