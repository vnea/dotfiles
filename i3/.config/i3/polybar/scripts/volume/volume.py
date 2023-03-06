#!/usr/bin/env python3

import subprocess
from socket import socket, AF_INET, SOCK_DGRAM

NO_VOLUME = None


def get_volume():
    if is_mute():
        return NO_VOLUME

    p1 = subprocess.Popen(
        ["amixer", "--device", "pulse", "get", "Master"],
        stdout=subprocess.PIPE
    )
    p2 = subprocess.Popen(
        ["grep", "%"],
        stdin=p1.stdout,
        stdout=subprocess.PIPE
    )
    p3 = subprocess.Popen(
        ["head", "-n", "1"],
        stdin=p2.stdout,
        stdout=subprocess.PIPE
    )
    p4 = subprocess.Popen(
        ["cut", "-d", '[', "-f", "2"],
        stdin=p3.stdout,
        stdout=subprocess.PIPE
    )
    p5 = subprocess.Popen(
        ["cut", "-d", '%', "-f", "1"],
        stdin=p4.stdout,
        stdout=subprocess.PIPE,
        text=True
    )

    return int(p5.communicate()[0])


def is_mute():
    p1 = subprocess.Popen(
        ["amixer", "--device", "pulse", "get", "Master"],
        stdout=subprocess.PIPE
    )
    p2 = subprocess.Popen(
        ["grep", "%"],
        stdin=p1.stdout,
        stdout=subprocess.PIPE
    )
    p3 = subprocess.Popen(
        ["grep", "-oE", "[^ ]+$"],
        stdin=p2.stdout,
        stdout=subprocess.PIPE
    )
    p4 = subprocess.Popen(
        ["grep", "off"],
        stdin=p3.stdout,
        stdout=subprocess.DEVNULL
    )

    p4.communicate()
    return p4.returncode == 0


def volume_up():
    subprocess.Popen(["amixer", "--device", "pulse", "set", "Master", "on"], stdout=subprocess.DEVNULL).communicate()
    subprocess.Popen(["amixer", "--device", "pulse", "set", "Master", "5%+"], stdout=subprocess.DEVNULL).communicate()


def volume_down():
    subprocess.Popen(["amixer", "--device", "pulse", "set", "Master", "on"], stdout=subprocess.DEVNULL).communicate()
    subprocess.Popen(["amixer", "--device", "pulse", "set", "Master", "5%-"], stdout=subprocess.DEVNULL).communicate()


def toggle_mute():
    subprocess \
        .Popen(["amixer", "--device", "pulse", "set", "Master", "1+", "toggle"], stdout=subprocess.DEVNULL) \
        .communicate()


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
