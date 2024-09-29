use strict;
use warnings;
use Irssi;

sub sig_message_public {
    my ($server, $msg, $nick, $address, $target) = @_;

    my $notification_msg = "[$target] $nick: $msg";

    system("notify=\$(notify-send -u normal -i notification-message-im -A 'open=Open IRC' '$notification_msg') && [[ \$notify == 'open' ]] && tmux has-session -t irc && exec xterm -e tmux attach -t irc >/dev/null 2>&1 &");
}

sub sig_message_private {
    my ($server, $msg, $nick, $address) = @_;

    system("notify=\$(notify-send -u critical -i notification-message-im -A 'open=Open IRC' '$nick' '$msg') && [[ \$notify == 'open' ]] && tmux has-session -t irc && exec xterm -e tmux attach -t irc >/dev/null 2>&1 &");
}

Irssi::signal_add('message public', 'sig_message_public');
Irssi::signal_add('message private', 'sig_message_private');
