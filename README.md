# LambdaContainer

Author: Kevin Shah

This repository is to get started with terraform using AWS lambda. We deploy a basic container image using AWS lambda handler and terraform library. 
This code is scripted mainly in python

reference to this code was taken from : https://aws.amazon.com/blogs/aws/new-for-aws-lambda-container-image-support/

Below ar ethe list of command that will help you get through the process.


### start by building a docker image 

1. docker build . -t lambda-container:0.0.1
2. docker run -p 9000:8080 lambda-container:0.0.1
3. (# incase curl doesnt work)
    Remove-item alias:curl
4. curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
note: use |(docker images)| to check for container images. 

### pushing the image to ecr 


5. aws ecr create-repository --repository-name lambda-container --image-scanning-configuration scanOnPush=true
6. docker tag lambda-container:0.0.1 123412341234.dkr.ecr.sa-east-1.amazonaws.com/lambda-container:0.0.1
7. aws ecr get-login-password | docker login --username AWS --password-stdin 198171447625.dkr.ecr.us-east-1.amazonaws.com
8. docker push 198171447625.dkr.ecr.us-east-1.amazonaws.com/lambda-container:0.0.1  
(output- The push refers to repository [198171447625.dkr.ecr.us-east-1.amazonaws.com/lambda-container])


error fix  (error :aws :: File association not found for extension .py)
CMD :
    assoc .py=pyautofile
    ftype pyautofile="C:\Anaconda2\python.exe" "%1" %*

### getting terraform to call lambda 

9. terraform init
10. terraform plan -out out.tfplan
11. terraform apply "out.tfplan"
12. aws lambda invoke --region us-east-1 --function-name lambda_conatiner out --log-type Tail --query 'LogResult' --output text| base64 -d (# aws lambda invoke --region us-east-1 --function-name lambda_conatiner out --log-type Tail )

### output is stored in out file as well as you can get in json format
13. cat out
