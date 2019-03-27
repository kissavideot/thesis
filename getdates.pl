#!/usr/bin/perl
use strict;
use warnings;


my $term = $ARGV[0];
my @clist = `git log`;
my ($commit,%commits,@order);
foreach(@clist) {
    if(/^commit\s(.*?)$/) {
        $commit = $1;
        push(@order,$commit); 
    }
    if(/^Date:\s(.*?)$/) {
        $commits{$commit} = $1;
    } 
}
foreach my $c (@order) {
    my @show = `git show $c`;
    foreach my $row (@show) {
        if($row =~ /$term/i) {
            print "\n$c $commits{$c}\n";
            print $row;
        }
    }  

}


#while(my($c,$date) = each(%commits)) {
#    my @show = `git show $c`;
#    foreach my $row (@show) {
#        if($row =~ /$term/) {
#            print "\n$c $date\n";
#            print $row;
#         }
#     }
#}
