# Detecting fake account registrations via bots using Amazon Fraud Detector

A simple web application and workshop platform intended as an educational tool for demonstrating how AWS infrastructure and services can be used to build compelling fraud detection system for eCommerce, retail, and other use-cases.
This project includes: notebooks, source codes, and CloudFormation templates to deploy all resources requred for this demo. 
The architecture is supported by several managed services including [Amazon API Gateway](https://aws.amazon.com/api-gateway/), [AWS Lambda](https://aws.amazon.com/lambda/), [Amazon Fraud Detector](https://aws.amazon.com/fraud-detector/), and [Amazon SageMaker](https://aws.amazon.com/sagemaker/), [Amazon S3](https://aws.amazon.com/s3/). The web user interface is built using the React framework

## Demo website

The quickest way to demonstrate how AFD can be used to detect bots is by using the demo website that has been created for this purpose. This website shows a registration form that can be filled in and submitted. The website tracks how long it takes the user to fill in the website and submits that information, together with the IP address and the email address to an AFD model, see architecture below:

![Architectural diagram](static/images/architecture.JPG?raw=true)

The (simplified) idea is that bots submit the registration form in an automated fashion and therefore much quicker and that bots choose random user names for the sign-up. The AFD model in this demo has been trained to pick up on those features that identify bots and return a risk score and an outcome (registration approved or denied).

When a regular user signs up on the demo website they will usually get their registration approved:

![Registration approved](static/images/registration_approved.JPG?raw=true)

The box in the lower left corner summarizes the data that has been submitted and also the AFD results that have been returned (the registration time is measured in milliseconds).

To get the sign-up denied one needs to be quite quick in filling in the form and submitting it. One trick that helps is using a random email address and copying it into the clipboard and then filling in the form quick:

![Registration denied](static/images/registration_denied.JPG?raw=true)

This repo also contains a [bot program](src/python/bot.py) that can be used to demonstrate how AFD works for this setup. We have found that customers like seeing the bot in action as it gives them a more concrete idea of what a bot attack looks like. This demo runs on Firefox with Geckodriver 0.27.0 -- you can find the latest version of [Geckodriver](https://github.com/mozilla/geckodriver/releases). You can also easily amend the script to run on Chrome, in this case you would need [Chromedriver](https://chromedriver.chromium.org/downloads)

# Getting Started

***IMPORTANT NOTE:** Deploying this demo application in your AWS account will create and consume AWS resources, which will cost money. Therefore, to avoid ongoing charges and to clean up all data, be sure to follow all workshop clean up instructions and shutdown/remove all resources by deleting the CloudFormation stack once you are finished.* 

**This project is for demonstration purposes only. You must comply with all applicable laws and regulations, including any laws and regulations related to email or text marketing, in any applicable country or region.**

To get Amazon Fraud Detector Demo running in your own AWS account, follow these instructions. If you are attending an AWS-led event where temporary AWS accounts are provided, this has likely already been done for you already.  Check with your event administrators.

## Step 1 - Get an AWS Account

If you do not have an AWS account, please see [How do I create and activate a new Amazon Web Services account?](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)

## Step 2 - Log into the AWS Console

Log into the [AWS console](https://console.aws.amazon.com/) if you are not already. 

Note: If you are logged in as an IAM user, ensure your account has permissions to create and manage the necessary resources and components for this application.

## Step 3 - Deploy to your AWS Account

After clicking one of the Launch Stack buttons below, follow the procedures to launch the template.

Region name | Region code | Launch
--- | --- | ---
Europe (Ireland) | eu-west-1 | [![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/create/review?templateURL=https://s3-eu-west-1.amazonaws.com/afddemo-eu-west-1/templates/template.yaml&stackName=afddemo&param_ResourceBucket=afddemo-eu-west-1)

The CloudFormation deployment will take less then 10 minutes to complete.

## Step 4 - Using the Amazon Fraud Detector Demo

Once you launch the CloudFormation stack, all of the services will go through a build and deployment cycle and deploy the Amazon Fraud Detector Demo. 

Compiling and deploying the web UI application and the services it uses can take some time. You can monitor progress in CodePipeline. Until this completes, you may see a Sample Application when accessing the public WebUI URL.

You can find the URL for the Amazon Fraud Detector Demo Web UI in the Outputs of your main CloudFormation stack (called `afddemo` unless you changed that option in the steps above). 

Look for the "WebURL" output parameter.

# Accessing Workshops

Amazon Fraud Detector Demo environment is designed to provide a series of interactive workshops that progressively add functionality to the Amazon Fraud Detector Demo application.

The workshops are deployed in a SageMaker Jupyter environment that is deployed in your CloudFormation stack.  To access the Amazon Fraud Detector Demo workshops after the CloudFormation stack has completed, browse to Amazon SageMaker in your AWS console, and then select Notebook Instances in the AWS console in your AWS account. 

You will see a running Notebook instance. Click "Open JupyterLab" for the Amazon Fraud Detector Demo notebook instance. 

# Known Issues

* The application was written for demonstration purposes and not for production use.
* You currently cannot deploy this project multiple times in the same AWS account and the same region. However, you can deploy the project into separate regions within the same AWS account.
* Make sure your CloudFormation stack name uses all lowercase letters.
* Currently only tested in the AWS regions provided in the deployment instructions above. The only limitation for deploying into other regions is [availability of all required services](https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/).

# Reporting Bugs

If you encounter a bug, please create a new issue with as much detail as possible and steps for reproducing the bug. See the [Contributing Guidelines](./CONTRIBUTING.md) for more details.

# License

This sample code is made available under a modified MIT license. See the LICENSE file.


## POC in a box

If your customer is interested in not only a demo but also in how to set up, train, and serve an AFD model, we have developed a [POC in a box](poc_deployment.md) that deploys all the required resources via a CloudFormation template.