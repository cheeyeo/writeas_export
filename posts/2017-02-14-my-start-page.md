So what is a start page and why is it a good idea have one? A start page is a page you first see when you open your browser. In my case, it will be a custom page which I have created that contains links and tools to help me. 

I headed over to the Reddit start page community to see what I could find. A lot of the previews were very cluttered and not as distraction free as I would like. Then I saw [this post](https://www.reddit.com/r/startpages/comments/5slwtn/minimal_and_customisable_start_typing_for/), it was perfect. 

**TLDR**; I copied the HTML and JS script, cleaned them up a bit. Added some static links to the bottom of the page and that was it! 

I now have my own [startup page](http://start.beardyjay.co.uk). 

<!--more-->

## What I changed

I wanted to automate everything about it like I do for my [main website](https://beardyjay.co.uk) and this is what I done. 

  - Uploaded the pages to a repository on [github.com](https://www.github.com). 
  - Attach the github repository to [TravisCI](https://travis-ci.org).
  - Added [Gulp](http://gulpjs.com/) to minimise the HTML and JS scripts. 
  - Create a [S3 Bucket](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html) to upload the static site too. 
  - Use [S3cmd](http://s3tools.org/s3cmd) to transfer the minimised files to the bucket.
  
  You can find my start page along with the Gulp and Travis configuration [Here](https://github.com/beardyjay/start.beardyjay.co.uk).