rem --------------------------
rem https://docs.microsoft.com/en-us/iis/troubleshoot/performance-issues/troubleshooting-iis-performance-issues-or-application-errors-using-logparser
rem https://www.cloudnotes.io/time-taken-and-logparser-for-web-site-statistics/
rem --------------------------
rem logparser "SELECT TOP 100 time-taken, cs-uri-stem INTO _SlowestPages.log FROM *.log WHERE extract_extension(to_lowercase(cs-uri-stem)) = 'aspx' ORDER BY time-taken DESC" -i:iisw3c -o:tsv > "u_ex211122-SlowPages.txt"
logparser "SELECT TOP 100 time-taken, cs-uri-stem FROM u_ex211123.log ORDER BY time-taken DESC" -i:iisw3c -o:tsv > "u_ex211123-SlowPages.txt"
