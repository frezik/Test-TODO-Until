use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Test::TODO::Until',
    AUTHOR              => q{Timm Murray <tmurray@doubleprime.com>},
    VERSION_FROM        => 'lib/Test/TODO/Until.pm',
    ABSTRACT_FROM       => 'lib/Test/TODO/Until.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'DateTime'   => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-TODO-Until-*' },
);
