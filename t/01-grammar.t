use Test;

use RDF::Turtle::Grammar;

my \P = RDF::Turtle::Grammar.new(:quiet);

sub t($rule,$str, Bool :$not) {
    if $not {
        nok P.parse( $str, :$rule ), "not $rule";
    } else {
        ok P.parse( $str, :$rule ), $rule;
    }
}


t 'hex', '0';
t 'hex', 'F';
t 'hex', 'G', :not;
t 'character', 'a';
t 'character', '△';
t 'character', 'xx', :not;
t 'ucharacter', 'a';
t 'ucharacter', '>', :not;
t 'relativeURI', 'abcde';
t 'uriref', '<abcde>';
t 'uriref', '<http://example.com#abcde>';
t 'uriref', 'nope', :not;
t 'resource', '<http://example.com>';
t 'qname', 'eg:Fullname';
t 'resource', '<url>';
t 'object', '<url>';
t 'literal', '"foo"';
t 'verb', 'a';
t 'verb', 'ex:isa';
t 'verb', '<foo>';
t 'triples', '<foo> <isa> <bar>';
t 'triples', ':x x:x x:x';
t 'triples', ':x a:x x:x';
t 'statement', '<foo> <isa> <bar> .';
t 'statement', '<foo> a <bar> .';
t 'TOP', '<foo> <isa> <bar> . <baz> <isa> <blarg> .';
t 'comment', "# foo\n";
t 'itemList', '"apple" "banana"';
t 'collection', '( "apple" "banana" )';
t 'integer', '2';
t 'lcharacter', 'a';
t 'longString', '"""a"""';
t 'longString', '"""abc
def"""';
t 'objectList', ':a :b :c';
t 'objectList', ':a :b "foo"';
t 'literal', '"""foo"""';
t 'object', '"""foo"""';
t 'objectList', ':a :b """foo"""';
t 'TOP', q:to/DONE/;
    :a :b """a long
    	literal with
    newlines""" .
    DONE
t 'datatypeString', '"2.345"^^<http://www.w3.org/2001/XMLSchema#decimal>';
t 'literal', '"2.345"^^<http://www.w3.org/2001/XMLSchema#decimal>';
t 'object', '"2.345"^^<http://www.w3.org/2001/XMLSchema#decimal>';
t 'objectList', '"2.345"^^<http://www.w3.org/2001/XMLSchema#decimal>';

done-testing;
