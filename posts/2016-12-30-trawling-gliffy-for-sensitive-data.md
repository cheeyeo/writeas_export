Gliffy.com is a tool that allows you to draw various diagrams ranging from flowcharts to network diagrams. Gliffy has multiple tiers of membership, the one that we are interested in is the free level - the limitation of this is that your diagrams get marked as read only to the public.

<!--more-->

## The Issue

When you create a new diagram a unique identifier (ID) will be assigned to that diagram, you would think that the ID would be randomly generated; however, this is not the case. All that Gliffy seem to do is increment the previously generated ID by 1, no matter if it's a private or public diagram. 

If you come across a diagram which is private, you get an Unauthorised" message with a 401 HTTP status code.

![enter image description here](http://i.imgur.com/nCkfRGm.png)

Also, if the user has removed the diagram and you then try to access the ID, you will get a "Not Found" error and a 404 HTTP status code.

![404 Not Found](http://i.imgur.com/Lqfx02d.png)

Using these helpful error codes, it is a little process to [create a script](http://fpaste.org/251177/38639697/) to download any diagram that has not been set to private or hasn't been removed by the user. Relying on human error, and with the help of Gliffy's ID generation, let's see what we can find...

## The Results

After I had looked at a few random ID's, it seemed to be that any diagrams created with an 8XXXXXX ID were first created in late 2014 until 2015, so that's the range I've. After creating a bash script, running it over a 4 hour period I managed to find and download **3,252** public diagrams from a total of **26,000** ID's scanned. Initially I cherry picked a few diagrams, and the results were eye-opening, ranging from full network diagrams to user authentication processes containing username/passwords.

**Example 1**:

This redacted diagram showed a wealth of information such as:

 - Public IP Address
 - Private IP Address
 - Company Name
 - Company Remote Locations
 - Line Numbers (Ref)

![Example 1](http://i.imgur.com/7vTNH1I.png)

**Example 2**:

I had to heavily redact this particular diagram as it was one of most technically vibrant diagrams from the sample I downloaded.

 - Public IP Address
 - Private IP Address
 - Firewall Rules
 - IPSec Tunnel Information
 - Company branding
 - Company Name
 - Company Remote Locations


![Example 2](http://i.imgur.com/IK8xAXr.png)


## The Fix

Don't use the free account for real world diagrams.

Gliffy could help the situation by not making the IDs so linear. I did contact Gliffy to ask if they had any intention of fixing the way the IDs are generated to reduce this risk, I received this reply:

> Hi Jay,
>
> Thanks for using Gliffy. We, unfortunately, do not have any current
> plans to change this.
>
> We have voted for it on your behalf in our public forum located here:
> http://support.gliffy.com/entries/20133138-Make-public-document-URLs-much-harder-to-guess-or-brute-force-attack
>
> We take these requests very seriously. The votes and comments these
> receive help us to gauge public interest and assist us in allocating
> resources for future development.
>

So it appears that Gliffy had known about this issue since 2011 when it was first brought up on their forums. If they haven't "fixed" it in 4 years, I suspect they never will...