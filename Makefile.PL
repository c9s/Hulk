use inc::Module::Install;

name     'Hulk';
all_from 'lib/Hulk.pm';
author   q{Cornelius (c9s) <cornelius.howl_at_gmail.com>};
license  'perl';

build_requires 'Test::More';
requires 'Any::Moose';
requires 'JSON::XS';

auto_install;

WriteAll;

