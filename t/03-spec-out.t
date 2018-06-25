#!perl6

use Test;
use RDF::Turtle::Actions;
use RDF::Turtle::Grammar;

%*ENV<RDF_TURTLE_NO_COLOR> = 1;

for $?FILE.IO.dirname.IO.child('tests').dir(test => / 'test-' [ \d+ ] '.ttl' $/) -> $f {
   my $grammar = RDF::Turtle::Grammar.new(:quiet);
   my $actions = RDF::Turtle::Actions.new;
   my $prefix = 'http://www.w3.org/2001/sw/DataAccess/df1/tests/test-00.ttl';
   $actions.set-base(abs => $prefix);

   my $match = $grammar.parse($f.slurp, :$actions);
   ok $match, $f.basename;
   my $triples-file = $f.Str.subst('.ttl','.out').IO;
   my $want = $triples-file.slurp;
   my $made = join "\n", $match.made.map: -> ( $x, $y, $z ) { "$x $y $z ." };
   is $made.trim, $want.trim, $triples-file.basename;
   last;
}

done-testing;

# vim: syn=perl6
