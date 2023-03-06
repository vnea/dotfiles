#!/usr/bin/env python3

import subprocess
from socket import socket, AF_INET, SOCK_DGRAM
import re

NO_VOLUME = None

regex_pattern_volume = re.compile(r'\b(\d+)%')


def get_volume():
    if is_mute():
        return NO_VOLUME

    p1 = subprocess.Popen(
        ["pactl", "--", "get-sink-volume", "@DEFAULT_SINK@"],
        stdout=subprocess.PIPE
    )

    pactl_volume_output = str(p1.communicate()[0])
    match = regex_pattern_volume.search(pactl_volume_output)

    return int(match.group(1))


def is_mute():
    amixer_output = str(subprocess.Popen(
        ["amixer", "--device", "pulse", "get", "Master"],
        stdout=subprocess.PIPE
    ).communicate()[0])

    return amixer_output.count("off") > 0


def volume_up():
    volume = get_volume()
    if volume >= 100:
        return

    subprocess.Popen([
        "pactl", "--", "set-sink-volume", "@DEFAULT_SINK@", "+5%"],
        stdout=subprocess.DEVNULL
    ).communicate()


def volume_down():
    subprocess.Popen([
        "pactl", "--", "set-sink-volume", "@DEFAULT_SINK@", "-5%"],
        stdout=subprocess.DEVNULL
    ).communicate()


def toggle_mute():
    subprocess.Popen([
        "pactl", "--", "set-sink-mute", "@DEFAULT_SINK@", "toggle"],
        stdout=subprocess.DEVNULL
    ).communicate()


def handle_socket_command(socket_command):
    match socket_command:
        case b"volume_up":
            volume_up()
        case b"volume_down":
            volume_down()
        case b"toggle_mute":
            toggle_mute()


def print_formatted_volume(volume):
    if volume == NO_VOLUME:
        text_volume = "🔇 Muted"
    elif volume == 0:
        text_volume = f"🔇 {volume}%"
    elif volume < 30:
        text_volume = f"󰕿 {volume}%"
    elif volume < 70:
        text_volume = f"󰕾 {volume}%"
    else:
        text_volume = f" {volume}%"

    print(text_volume, flush=True)


def send_notification(volume):
    icon_folder_base_path = "/usr/share/icons/Papirus/48x48/status"
    timeout = 500
    notification_id = 555

    if is_mute():
        icon_path = f"{icon_folder_base_path}/notification-audio-volume-muted.svg"
        subprocess.Popen([
            "dunstify",
            "--replace", str(notification_id),
            "--appname", "Volume",
            "--icon", icon_path,
            "--timeout", str(timeout),
            "Muted"
        ])

        return

    if volume == 0:
        icon_path = f"{icon_folder_base_path}/notification-audio-volume-muted.svg"
    elif volume < 30:
        icon_path = f"{icon_folder_base_path}/notification-audio-volume-low.svg"
    elif volume < 70:
        icon_path = f"{icon_folder_base_path}/notification-audio-volume-medium.svg"
    else:
        icon_path = f"{icon_folder_base_path}/notification-audio-volume-high.svg"

    subprocess.Popen([
        "dunstify",
        "--replace", str(notification_id),
        "--appname", "Volume",
        "--icon", icon_path,
        "--timeout", str(timeout),
        "--hints", f"int:value:{volume}",
        str(volume)
    ])


def start():
    volume = get_volume()
    print_formatted_volume(volume)

    server_socket = socket(AF_INET, SOCK_DGRAM)
    server_socket.bind(("127.0.0.1", 60001))
    while True:
        socket_command, _ = server_socket.recvfrom(1024)
        handle_socket_command(socket_command)

        volume = get_volume()
        print_formatted_volume(volume)
        send_notification(volume)


if __name__ == "__main__":
    start()
