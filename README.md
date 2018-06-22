This is a parser for the Terse RDF Triple Language.

See https://www.w3.org/TeamSubmission/turtle/.

It includes a sample command line parser, [eg/parse.p6](eg/parse.p6).

Sample usage:

Parse a TTL file:

    ./eg/parse.p6 input.ttl

Convert to N-triples format:

    ./eg/parse.p6 input.ttl --triples

It also includes the TTL spec tests (in [t/tests](t/tests)).

