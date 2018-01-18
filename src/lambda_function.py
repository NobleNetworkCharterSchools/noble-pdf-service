"""
pdf_service/src/lambda_function.py


"""
import os

import boto3
from weasyprint import HTML


def lambda_handler(event, context):
    """Save pdf to bucket.

    ...
    """
    local_filepath = "/tmp/college-411.pdf"

    HTML("https://college-411.herokuapp.com").write_pdf(local_filepath)

    # save to s3
    bucket_name = os.environ["BUCKET_NAME"]
    push_to_s3(local_filepath, bucket_name)


def push_to_s3(file_path, bucket_name):
    """Push the file at file_path to the S3 bucket_name.

    TODO common aws utils?
    """

    s3 = boto3.resource("s3")
    bucket = s3.Bucket(bucket_name)
    bucket.upload_file(Key="college-411.pdf", Filename=file_path)


