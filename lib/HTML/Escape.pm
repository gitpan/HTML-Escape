package HTML::Escape;
use strict;
use warnings;
use 5.008008;
our $VERSION = '1.00';
use parent qw/Exporter/;

our $TESTING_PERL_ONLY;
$TESTING_PERL_ONLY = $ENV{HTML_ESCAPE_PUREPERL} ? 1 : 0
        unless defined $TESTING_PERL_ONLY;

unless($TESTING_PERL_ONLY){
    local $@;
    $TESTING_PERL_ONLY = !eval{
        require XSLoader;
        XSLoader::load(__PACKAGE__, $VERSION);
    };
}
if ($TESTING_PERL_ONLY) {
    ## no critic.
    require 'HTML/Escape/PurePerl.pm' # not to create the namespace
}

our @EXPORT = qw/escape_html/;

1;
__END__

=encoding utf8

=head1 NAME

HTML::Escape - Extremely fast HTML escape

=head1 SYNOPSIS

    use HTML::Escape qw/escape_html/;

    escape_html("<^o^>");

=head1 DESCRIPTION

This module escapes HTML's special chars. It's same as PHP's htmlspecialchars.

This module uses XS for better performance.
And also provides pure perl version.

=head1 FAQ

=over 4

=item Is there a unescape_html?

No. Unescaping HTML needs a lot of code, gfx don't want to do it.
Please use L<HTML::Entities> for it.

=back

=head1 BENCHMARK

                     Rate HTML::Entities   HTML::Escape
    HTML::Entities 14.0/s             --           -91%
    HTML::Escape    150/s           975%             --

=head1 AUTHOR

Goro Fuji

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF@ GMAIL COME<gt>

=head1 SEE ALSO

L<Text::Xslate>, L<HTML::Entities>

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
