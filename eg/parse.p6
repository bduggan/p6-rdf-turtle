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
    say @$out.join(" .\n") ~ " .\n";
}

# [15]    datatypeString    ::=    quotedString '^^' resource
# [16]    integer     ::=    ('-' | '+') ? [0-9]+
# [17]    double      ::=    ('-' | '+') ? ( [0-9]+ '.' [0-9]* exponent | '.' ([0-9])+ exponent | ([0-9])+ exponent )
# [18]    decimal     ::=    ('-' | '+')? ( [0-9]+ '.' [0-9]* | '.' ([0-9])+ | ([0-9])+ )
# [19]    exponent    ::=    [eE] ('-' | '+')? [0-9]+
# [20]    boolean     ::=    'true' | 'false'
# [22]    itemList    ::=    object+
# [26]    nodeID      ::=    '_:' name
# [29]    language    ::=    [a-z]+ ('-' [a-z0-9]+ )*
# [37]    longString  ::=    #x22 #x22 #x22 lcharacter* #x22 #x22 #x22
# [43]    lcharacter  ::=    echaracter | '\"' | #x9 | #xA | #xD
