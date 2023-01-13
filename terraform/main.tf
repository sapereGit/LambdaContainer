resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


/* data "aws_ecr_repository" "service" {
  name = "lambda-conatainer"
} */


resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  function_name = "lambda_conatiner"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "app.handler"
  runtime       = "python3.9"
  #image_uri     = "${data.aws_ecr_repository.service.repository_url}:0.0.1"
   image_uri     = "198171447625.dkr.ecr.us-east-1.amazonaws.com/lambda-container:0.0.1"
   /* image_uri = "198171447625.dkr.ecr.us-east-1.amazonaws.com/lambda-container" */                                                                         
  package_type  = "Image"
}