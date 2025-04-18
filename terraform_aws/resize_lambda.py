import boto3
from PIL import Image
import io

s3 = boto3.client('s3')

def lambda_handler(event, context):
    source_bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    destination_bucket = 'image-output-bucket-unique-123456'

    image_obj = s3.get_object(Bucket=source_bucket, Key=key)
    image_data = image_obj['Body'].read()
    image = Image.open(io.BytesIO(image_data))

    # Resize the image to 100x100
    image = image.resize((100, 100))
    buffer = io.BytesIO()
    image.save(buffer, format='JPEG')

    # Upload to output bucket
    s3.put_object(Bucket=destination_bucket, Key=key, Body=buffer.getvalue())

    return {"status": "Image processed and stored."}