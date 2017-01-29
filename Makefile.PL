use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;
use Module::Metadata;

WriteMakefile(
    NAME             => 'Moonshine::Magic',
    AUTHOR           => q{Robert Acock <thisusedtobeanemail@gmail.com>},
    VERSION_FROM     => 'lib/Moonshine/Magic.pm',
    ABSTRACT_FROM    => 'lib/Moonshine/Magic.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    	'Module::Metadata' => 0,
	},
    BUILD_REQUIRES => {
        'Test::More' => 0,
        'Moonshine::Test' => 0,
    },
    PREREQ_PM => {
        'UNIVERSAL::Object' => 0,
        'BEGIN::Lift' => 0,
        'strict' => 0,
        'warnings' => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Moonshine-Magic-*' },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/ThisUsedToBeAnEmail/Moonshine-Magic.git',
                web  => 'https://github.com/ThisUsedToBeAnEmail/Moonshine-Magic',
            },
        },
    },
    META_ADD => {
        provides => Module::Metadata->provides(version => '2', dir => 'lib'),
    },
);
