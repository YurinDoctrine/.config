use strict;
use warnings;
use Irssi;

sub sig_message_public {
    my ($server, $msg, $nick, $address, $target) = @_;

    my $notification_msg = "[$target] $nick: $msg";

    system("notify-send '$notification_msg' -u normal -i notification-message-im");
}

Irssi::signal_add('message public', 'sig_message_public');
