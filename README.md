# blocklist
Tiny CBL block list monitor that is able to monitor a virtually unlimited amount of servers against popular CBL blocklists.

In ./conf/iplist.conf, replace xxx.xxx.xxx.xxx with the ipaddress or hostname of every server that is being monitored against
the CBL lists.  ./conf/blocklist.conf contains the list of publically available CBL sites to get started.

I have encluded a simple command line tool ./uniqueadd that will compare a list of new CBLs to the list on file
to avoid adding duplicates to the master list.

The final bit of configuration is in blocklib.rb, in which the user of this tool will need to set the smtp server for notifications,
the list of email addresses that will be notified and the noc master email as the point of origin.  In that small file,
it is suggested, though not required, to set the time of day for monitoring and the interval the checks are occuring.
Those flags are listed in the source comments.

Copyright (c) 2015 Colby Shores.
All rights reserved.

Redistribution and use in source and binary forms are permitted
provided that the above copyright notice and this paragraph are
duplicated in all such forms and that any documentation,
advertising materials, and other materials related to such
distribution and use acknowledge that the software was developed
by the <organization>. The name of the
<organization> may not be used to endorse or promote products derived
from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
