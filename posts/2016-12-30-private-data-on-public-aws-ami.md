I was shocked to see how many public AMI are found containing private data.

<!--more-->
## First of all, what are AMIs?

Amazon Machine Images are a VM skeleton containing

  * The root volume.
  * Who can access the AMI.
  * The block device mapping for what volumes to attach.

Having an AMI makes deploying custom instances easy and also enables other services such as Auto scaling possible.

## What is the problem?

By default when you create an AMI they are set to private so that only you can access these, this is good! However, if the AMI is public, it means that anyone can deploy an EC2 instance based on your custom AMI which will include the root volume you attached to it.

Amazon allows you to search for AMI's that have been made public either via the AWS CLI tool or the AWS console. Doing a search for AMIs for keywords like **internal**, **data** or **customer** returns a surprising amount of results.

![Screenshot](http://i.imgur.com/tMPg1zQ.png)

You can also dump all the public AMI data via the AWS CLI and parse/search it as you like.

     aws ec2 describe-images --region=eu-west-1

Below is a screenshot of an AMI tagged as **internal** deployed on a t2.micro. It shows the bash history of everything that was done.

![Screenshot](http://i.imgur.com/gIiblxV.png)

The above example was just one of many images that I found like this so if you have any AMI's on AWS then please double check and make sure they are private else you may well be exposing some critical data!

When I was looking into this I found loads of data such as:

  * API tokens
  * Bash history
  * MySQL username & passwords
  * Username & Passwords
  * Source code for applications
  * SSH Private keys (.ppk)

## What can I do

Amazon provides a [best practice guide][AMI-guide] on how to share AMI's so have I a look at this if you want to share an AMI.

AMIs are region specific, and this means that other AWS regions may have other AMIs, so it is worth checking them all.

To make this easier for you, I have created a python script which will search all [AWS regions][aws_r] and list any that are public. You can copy and paste the script below.  

```python
#!/usr/bin/env python
#
# Search all of your own AMIs for any that are public on
# all known regions.
#
# jay@beardyjay.co.uk
#

import boto.ec2
import os
import sys

access_key = "enter key"
access_id = "enter id"

fmt = '{0:15} {1:15} {2:15} {3:20}'

# Dont use boto to get regions as some return 401, gov regions
regions = ['us-east-1','us-west-1','us-west-2','eu-west-1','sa-east-1',
        'ap-southeast-1','ap-southeast-2','ap-northeast-1',
        'ap-northeast-2','eu-central-1']

print(fmt.format("Name", "ID", "State", "Region"))
for region in regions:
    ec2_connection = boto.ec2.connect_to_region(region,
            aws_secret_access_key=access_key,
            aws_access_key_id=access_id)

    images = ec2_connection.get_all_images(
            owners='self',
            filters={
                'is_public': 'true',
                },
            )

    for image in images:
       print(fmt.format(image.name,image.id,image.state,region))
```

[AMI-guide]: <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/building-shared-amis.html>
[aws_r]: <http://docs.aws.amazon.com/general/latest/gr/rande.html#ec2_region>
