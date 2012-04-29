package MT::Plugin::OMV::PublishDateTimeToNow;
# $Id$
# PublishDateTimeToNow
#       Copyright (c) 2008 Open MagicVox.net - http://www.magicvox.net/

use strict;

use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new({
    name => __PACKAGE__,
});
MT->add_plugin( $plugin );

### Registry
sub init_registry {
    my $plugin = shift;
    $plugin->registry({
        callbacks => {
           'MT::App::CMS::template_source.edit_entry' => \&_edit_entry_source,
        },
    });
}



sub _edit_entry_source {
    my( $eh_ref, $app_ref, $tmpl_ref ) = @_;

    # Omit a button for calendar control
    my $old = quotemeta( <<'HTMLHEREDOC' );
                <a href="javascript:void(0);" mt:command="open-calendar-created-on" class="date-picker" title="<__trans phrase="Select entry date">"><span>Choose Date</span></a>
HTMLHEREDOC
    my $new = '';
    $$tmpl_ref =~ s/$old/$new/;

    # Create a new button for getting current timestamp.
    $old = quotemeta( <<'HTMLHEREDOC' );
                <input class="entry-time" name="authored_on_time" tabindex="11" value="<$mt:var name="authored_on_time" escape="html"$>" />
HTMLHEREDOC
    if ($$tmpl_ref !~ /$old/) { # 4.25
        $old = quotemeta( <<'HTMLHEREDOC' );
                <input class="entry-time" name="authored_on_time" value="<$mt:var name="authored_on_time" escape="html"$>" />
HTMLHEREDOC
    }
    $new = <<HTMLHEREDOC;
<script>
function set_current_time() {
    var cur_time = new Date();
    var cur_year    = cur_time.getFullYear();
    var cur_month   = cur_time.getMonth() + 1;
    var cur_day     = cur_time.getDate();
    var cur_hour    = cur_time.getHours();
    var cur_minutes = cur_time.getMinutes();
    var cur_seconds = cur_time.getSeconds();

    if (1 == (new String (cur_month  )).length) cur_month   = '0' + cur_month;
    if (1 == (new String (cur_day    )).length) cur_day     = '0' + cur_day;
    if (1 == (new String (cur_hour   )).length) cur_hour    = '0' + cur_hour;
    if (1 == (new String (cur_minutes)).length) cur_minutes = '0' + cur_minutes;
    if (1 == (new String (cur_seconds)).length) cur_seconds = '0' + cur_seconds;

    var e_date = document.forms['entry_form'].authored_on_date;
    e_date.value = cur_year + '-' + cur_month + '-' + cur_day;

    var e_time = document.forms['entry_form'].authored_on_time;
    e_time.value = cur_hour + ':' + cur_minutes + ':' + cur_seconds;
}
</script>
<a href="javascript:void(set_current_time());" class="date-picker" title="<__trans phrase="Set current timestamp">"><span>Set current timestamp</span></a>
HTMLHEREDOC
    $$tmpl_ref =~ s/($old)/$1$new/;
}

1;