#!/usr/bin/env perl6

use lib 'lib';
use RDF::Turtle::Actions;
use RDF::Turtle::Grammar;

my %*SUB-MAIN-OPTS = :named-anywhere;

multi MAIN($file) {
    my \P = RDF::Turtle::Grammar.new;
    say P.parse($file.IO.slurp);
}

multi MAIN($file, Bool :$triples) {
    my \P = RDF::Turtle::Grammar.new;
    my $actions = RDF::Turtle::Actions.new;
    my $match = P.parse($file.IO.slurp, :$actions) or die "parse failed";
    my $out = $match.made;
    if $triples {
        say @$out.join(" .\n") ~ " .\n";
    } else {
        say $match;
    }
}
