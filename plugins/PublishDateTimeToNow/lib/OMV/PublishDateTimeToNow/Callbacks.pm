package OMV::PublishDateTimeToNow::Callbacks;
# PublishDateTimeToNow (C) <Year> Piroli YUKARINOMIYA (Open MagicVox.net)
# This program is distributed under the terms of the GNU Lesser General Public License, version 3.
# $Id$

use strict;
use warnings;
use MT;

use vars qw( $VENDOR $MYNAME $FULLNAME );
$FULLNAME = join '::',
        (($VENDOR, $MYNAME) = (split /::/, __PACKAGE__)[0, 1]);

sub instance { MT->component($FULLNAME); }



### MT::App::CMS::template_param.edit_entry
sub template_param_edit_entry {
    my ($cb, $app, $param, $tmpl) = @_;

    my $authored_on = $tmpl->getElementById ('authored_on');
    my $button = $tmpl->createTextNode (&instance->translate_templatized (<<"HTMLHEREDOC"));
<script type="text/javascript">
// $FULLNAME
function set_current_time () {
    var cur_time = new Date ();
    var cur_year    = cur_time.getFullYear ();
    var cur_month   = cur_time.getMonth () + 1;
    var cur_day     = cur_time.getDate ();
    var cur_hour    = cur_time.getHours ();
    var cur_minutes = cur_time.getMinutes ();
    var cur_seconds = cur_time.getSeconds ();

    if (1 == (new String (cur_month  )).length) cur_month   = '0' + cur_month;
    if (1 == (new String (cur_day    )).length) cur_day     = '0' + cur_day;
    if (1 == (new String (cur_hour   )).length) cur_hour    = '0' + cur_hour;
    if (1 == (new String (cur_minutes)).length) cur_minutes = '0' + cur_minutes;
    if (1 == (new String (cur_seconds)).length) cur_seconds = '0' + cur_seconds;

    var e_date = document.forms['entry_form'].authored_on_date;
    e_date.value = [ cur_year, cur_month, cur_day ].join('-');

    var e_time = document.forms['entry_form'].authored_on_time;
    e_time.value = [ cur_hour, cur_minutes, cur_seconds ].join(':');
}
</script>
<a href="#" onclick="set_current_time(); return false;" title="<__trans phrase="Set current timestamp">"><img src="<mt:var name="static_uri">plugins/$VENDOR/$MYNAME/player_time.png" alt="<__trans phrase="Set current timestamp">" /></a>
HTMLHEREDOC
    $authored_on->appendChild ($button);
}

1;