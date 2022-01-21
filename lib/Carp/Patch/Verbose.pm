package Carp::Patch::Verbose;

use 5.010001;
use strict;
no warnings;

use Module::Patch qw();
use base qw(Module::Patch);

# AUTHORITY
# DATE
# DIST
# VERSION

my $old_MaxArgLen;
my $old_MaxArgNums;
our %config;

sub patch_data {
    return {
        v => 3,
        patches => [
        ],
        config => {
        },
        after_patch => sub {
            my $old_MaxArgLen  = $Carp::MaxArgLen ; $Carp::MaxArgLen  = 999_999;
            my $old_MaxArgNums = $Carp::MaxArgNums; $Carp::MaxArgNums = 0;
        },
        after_unpatch => sub {
            $Carp::MaxArgLen  = $old_MaxArgLen  if defined $old_MaxArgLen ; undef $old_MaxArgLen;
            $Carp::MaxArgNums = $old_MaxArgNums if defined $old_MaxArgNums; undef $old_MaxArgNums;
        },
   };
}

1;
# ABSTRACT: Set some Carp variables so stack trace is more verbose

=for Pod::Coverage ^(patch_data)$

=head1 SYNOPSIS

 % perl -MCarp::Patch::Verbose -d:Confess ...


=head1 DESCRIPTION

This is not so much a "patch" for L<Carp>, but just a convenient way to set some
Carp package variables from the command-line. Currently can set these variables:

 $Carp::MaxArgLen  # from the default 64 to 0 (print all)
 $Carp::MaxArgNums # from the default  8 to 0 (print all)


=head1 append:SEE ALSO

L<Carp::Patch::Config>

L<Devel::Confess>
