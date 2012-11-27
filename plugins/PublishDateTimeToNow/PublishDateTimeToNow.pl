package MT::Plugin::Editing::OMV::PublishDateTimeToNow;
# PublishDateTimeToNow (C) 2008-2012 Piroli YUKARINOMIYA (Open MagicVox.net)
# This program is distributed under the terms of the GNU Lesser General Public License, version 3.
# $Id$

use strict;
use warnings;
use MT 5;

use vars qw( $VENDOR $MYNAME $FULLNAME $VERSION $SCHEMA_VERSION );
$FULLNAME = join '::',
        (($VENDOR, $MYNAME) = (split /::/, __PACKAGE__)[-2, -1]);
(my $revision = '$Rev$') =~ s/\D//g;
$VERSION = 'v0.10'. ($revision ? ".$revision" : '');

use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new ({
    id => $FULLNAME,
    key => $FULLNAME,
    name => $MYNAME,
    version => $VERSION,
    schema_version => $SCHEMA_VERSION,
    author_name => 'Open MagicVox.net',
    author_link => 'http://www.magicvox.net/',
    plugin_link => 'http://www.magicvox.net/archive/2008/11062036/', # Blog
    doc_link => "http://lab.magicvox.net/trac/mt-plugins/wiki/$MYNAME", # tracWiki
    description => <<'HTMLHEREDOC',
<__trans phrase="Add a button to modify authored on datetime to current time stamp">
HTMLHEREDOC
    l10n_class => "${FULLNAME}::L10N",
    registry => {
        applications => {
            cms => {
                callbacks => {
                   'template_param.edit_entry' => "${FULLNAME}::Callbacks::template_param_edit_entry",
                },
            },
        },
    },
});
MT->add_plugin ($plugin);

sub instance { $plugin }

1;