use Test;
use AttrX::Mooish;

my $inst;
my class Foo1 {
    has $.bar is rw is mooish(:filter);

    multi method filter-bar ( Str $val ) {
        is $val, "a string value", "string value method";
    }

    multi method filter-bar ( Int $val where * > 100 ) {
        is $val, 314, "big integer value";
    }

    multi method filter-bar ( Int $val ) {
        is $val, 42, "integer value method";
    }
}

$inst = Foo1.new;

$inst.bar = "a string value";
$inst.bar = 42;
$inst.bar = 314;

my class Foo2 {
    has BagHash $.baz is mooish(:lazy, :filter('my-filter'), :predicate);

    method build-baz { <a b b c>.BagHash }
    method my-filter ($val) { $val }
}

$inst = Foo2.new;
nok $inst.has-baz, "baz is not inited yet";
is $inst.baz, <a b b c>.BagHash, "baz built";
ok $inst.has-baz, "baz is inited";

done-testing;
# vim: ft=perl6
