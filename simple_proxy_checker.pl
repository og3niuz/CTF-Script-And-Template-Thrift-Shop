#!/usr/bin/perl
#

use WWW::Mechanize;
@proxy=`cat proxy.lst`;

foreach $i (@proxy) {
 chomp($i);
 my $go = WWW::Mechanize->new( agent=> "Mozilla/5.0" );
 $go->proxy(['http'], 'http://'.$i.'/');
 $go->get('http://www.whatismyip.com');
 $match = $go->content;
# print "$match\n";
 my($crap,$ip)=split(/^(.*):/,$i);print "$i -> ";
  if ($match =~ m/(.*)Your IP Is $ip(.*)/ ) { print "Ok.\n";
                                              open(LOG,">> proxy.log"); print LOG "$i\n"; close(LOG);
                                            }
   else { print "Nop\n"; }
}
