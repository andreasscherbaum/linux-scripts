#!/usr/bin/env perl
#
# transform a timestamp into unixtime and vice versa
#
# written by Andreas 'ads' Scherbaum <ads@wars-nicht.de>
#

use strict;
use Date::Calc qw(:all);


$time = join(" ", @ARGV);

# print help if no parameter
if (!$time) {
    print "usage:\n";
    print "$0 unixtime\n";
    print "$0 dd.mm.yyyy [hh:mm:ss]\n";
    print "current unixtime: " . time() . "\n";

    exit(0);
}


if ($time !~ /\./) {
    # assuming unix time
    ($sec, $min, $hour, $mday, $month, $year, $wday, $yday, $isdst) = gmtime($time);
    $month++;
    $year = $year + 1900;

    printf("time: %02d.%02d.%04d %02d:%02d:%02d\n", $mday, $month, $year, $hour, $min, $sec);
} elsif ($time =~ /^(\d{1,2})\.(\d{1,2})\.(\d\d\d\d)\s(\d{1,2}):(\d{1,2}):(\d{1,2})$/) {
    ($dd, $dh, $dm, $ds) = Delta_DHMS(1970, 1, 1, 0, 0, 0,
                                    $3, $2, $1, $4, $5, $6);
    $seconds = $dd * 86400 + $dh * 3600 + $dm * 60 + $ds;

    print "unixtime: $seconds\n";
} elsif ($time =~ /^(\d{1,2})\.(\d{1,2})\.(\d\d\d\d)$/) {
    $dd = Delta_Days(1970, 1, 1, $3, $2, $1);
    $seconds = $dd * 86400;

    print "unixtime: $seconds\n";
} else {
    print "time unknown! ($time)\n";
    exit(1);
}
