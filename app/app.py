import sys
def handler(event, context): 
    print('Hello from AWS Lambda using Python in a container')
    return 'Hello from AWS Lambda using Python' + sys.version + '!'