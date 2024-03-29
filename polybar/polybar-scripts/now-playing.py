#!/usr/bin/env python3
import dbus
import signal
import time
from unicodedata import east_asian_width

# Config options

# (int) : Length of media info string. If length of string exceedes this value, the text will scroll. Default value is 20
message_display_len = 32

# (int) : Font index of polybar. this value should be 1 more than the font value specified in polybar config.
font_index = 1

# (float) : Update speed of the text in seconds.
update_delay = 0.5

# (list) : list of metadata fields based on mpris sepecification.
# For more details/ field names, refer [mpris sepecification](https://www.freedesktop.org/wiki/Specifications/mpris-spec/metadata/)
metadata_fields = ["xesam:title", "xesam:artist"]

# (char) : separator for metadata fields
metadata_separator = "-"

# (bool) : Hide text when no player is available? True disables the output for no players.
hide_output = False

# Defult initialization
current_player = None
player_names = None
players = None
message = None
display_text = ""
display_prefix = ""
display_suffix = ""
last_player_name = None

session_bus = dbus.SessionBus()

def get_name(player_name ):
    if player_name not in player_names:
        return
    name = ".".join(player_name.split(".")[3:])
    return name

def get_name_by_index(index):
    if index >= len(player_names):
        return
    return get_name(player_names[index])

def get_status(player):
    status = ""
    try:
        status = player.Get('org.mpris.MediaPlayer2.Player', 'PlaybackStatus', dbus_interface='org.freedesktop.DBus.Properties')
    except Exception as e:
        pass
    return status

def get_metadata(player):
    metadata = {}
    try:
        metadata = player.Get('org.mpris.MediaPlayer2.Player', 'Metadata', dbus_interface='org.freedesktop.DBus.Properties')
    except Exception as e:
        pass
    return metadata

def update_prefix_suffix(player_name="", status=""):
    global display_prefix, display_suffix, status_paused

    suffix = ""
    if status == "Playing":
        suffix += ""
        status_paused = False
    else:
        suffix += ""
        status_paused = True
    suffix += ""
    # print(suffix)
    display_suffix = suffix

def update_players():
    global player_names, players, session_bus, current_player, last_player_name
    player_names = [service  for service in session_bus.list_names() if service.startswith('org.mpris.MediaPlayer2.')]
    players = [session_bus.get_object(service, '/org/mpris/MediaPlayer2') for service in player_names]
    if last_player_name != get_name(current_player):
        for index, player in enumerate(player_names):
            if get_name(player) == last_player_name:
                current_player = index

def update_message():
    global players, current_player,player_names, message, display_text, message_display_len, display_suffix, last_player_name
    if len(players) == 0:
        tmp_message = ""
        update_prefix_suffix()
    else:
        name = get_name_by_index(current_player)
        status = get_status(players[current_player])
        metadata_obj = get_metadata(players[current_player])
        metadata_string_list = []
        for field in metadata_fields:
            result = metadata_obj.get(field)
            if not result:
                result = ""
                break
            if type(result) == dbus.Array:
                result = result[0]
                metadata_separator = "-"
            metadata_string_list.append(str(result))
        metadata_string = (" "+metadata_separator+" ").join(metadata_string_list)
        if visual_len(metadata_string) > message_display_len:
            message_display_len = 32
            metadata_string = metadata_string + " "
        else:
            message_display_len = visual_len(metadata_string)
        update_prefix_suffix(name,status)
        tmp_message = ""
        if metadata_string:
            tmp_message += str(metadata_string)
        last_player_name = name
    if message != tmp_message:
        message = tmp_message
        display_text = message

def scroll():
    global display_text, message_display_len, status_paused
    if not status_paused:
        if visual_len(display_text) > message_display_len:
            display_text = display_text[1:] + display_text[0]
        elif visual_len(display_text) < message_display_len:
            display_text += " "*(message_display_len - len(display_text))
    update_players()

def visual_len(text):
    visual_length = 0
    for ch in text:
        width = east_asian_width(ch)
        if width == 'W' or width == 'F':
            visual_length += 2
        visual_length += 1
    return visual_length

def make_visual_len(text, visual_desired_length):
    visual_length = 0
    altered_text = ''
    for char in text:
        if visual_length < visual_desired_length:
            width = east_asian_width(char)
            if width == 'W' or width == 'F':
                visual_length += 2
            else:
                visual_length += 1
            altered_text += char
        else:
            break
    if visual_length == visual_desired_length + 1:
        altered_text = altered_text[:-1] + ' '
    elif visual_length < visual_desired_length:
        altered_text += ' ' * (visual_desired_length - visual_length)
    return altered_text

def print_text():
    global display_text, message_display_len, players, player_names, display_prefix, display_suffix
    if hide_output and len(players)==0:
        print("", flush = True)
        return
    scroll()
    print(display_prefix + " " +
        "%%{T%d}" % (font_index) +
        make_visual_len(display_text, message_display_len) +
        "%{T-}" + display_suffix, flush=True)

def main():
    global current_player, players
    update_players()
    current_player = 0
    while True:
        time.sleep(update_delay)
        update_players()
        update_message()
        print_text()

if __name__ == '__main__':
    main()
