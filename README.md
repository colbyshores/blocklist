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
