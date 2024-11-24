import boto3
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Initialize EC2 client
ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    # Example: Extract the instance ID from the event
    instance_id = event.get('detail', {}).get('instance-id', 'UNKNOWN')
    
    if instance_id == 'UNKNOWN':
        logger.error("Instance ID not found in event.")
        return {"status": "failed", "message": "Instance ID missing in event"}

    try:
        # Log the instance ID
        logger.info(f"Rebooting instance: {instance_id}")

        # Reboot the instance
        ec2.reboot_instances(InstanceIds=[instance_id])
        logger.info(f"Instance {instance_id} rebooted successfully.")
        return {"status": "success", "message": f"Rebooted instance {instance_id}"}

    except Exception as e:
        logger.error(f"Failed to reboot instance {instance_id}: {str(e)}")
        return {"status": "failed", "message": str(e)}
