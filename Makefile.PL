use inc::Module::Install;

name     'Web-Action-Dispatcher';
all_from 'lib/Web/Action/Dispatcher.pm';
author   q{Cornelius <cornelius.howl_at_gmail.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

