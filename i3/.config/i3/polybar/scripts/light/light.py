#!/usr/bin/env python3

import subprocess
from socket import socket, AF_INET, SOCK_DGRAM


def get_light():
    p1 = subprocess.Popen(["light", "-G"], stdout=subprocess.PIPE, text=True)

    light_decimal = p1.communicate()[0]

    return int(light_decimal.split(".")[0])


def light_up():
    subprocess.Popen(["light", "-A", "5"], stdout=subprocess.DEVNULL).communicate()


def light_down():
    light = get_light()
    if light <= 5:
        return

    subprocess.Popen(["light", "-U", "5"], stdout=subprocess.DEVNULL).communicate()


def handle_socket_command(socket_command):
    match socket_command:
        case b"light_up":
            light_up()
        case b"light_down":
            light_down()


def print_formatted_light(light):
    if light <= 5:
        text_light = f"󰃚 {light}%"
    elif light <= 20:
        text_light = f"󰃛 {light}%"
    elif light <= 35:
        text_light = f"󰃜 {light}%"
    elif light <= 50:
        text_light = f"󰃝 {light}%"
    elif light <= 65:
        text_light = f"󰃞 {light}%"
    elif light <= 80:
        text_light = f"󰃟 {light}%"
    else:
        text_light = f"󰃠 {light}%"

    print(text_light, flush=True)


def send_notification(light):
    icon_folder_base_path = "/usr/share/icons/Papirus/48x48/status"
    timeout = 500
    notification_id = 555

    if light <= 25:
        icon_path = f"{icon_folder_base_path}/notification-display-brightness-low.svg"
    elif light <= 50:
        icon_path = f"{icon_folder_base_path}/notification-display-brightness-medium.svg"
    elif light <= 75:
        icon_path = f"{icon_folder_base_path}/notification-display-brightness-high.svg"
    else:
        icon_path = f"{icon_folder_base_path}/notification-display-brightness-full.svg"

    subprocess.Popen([
        "dunstify",
        "--replace", str(notification_id),
        "--appname", "Light",
        "--icon", icon_path,
        "--timeout", str(timeout),
        "--hints", f"int:value:{light}",
        str(light)
    ])


def start():
    light = get_light()
    print_formatted_light(light)

    server_socket = socket(AF_INET, SOCK_DGRAM)
    server_socket.bind(("127.0.0.1", 60003))
    while True:
        socket_command, _ = server_socket.recvfrom(1024)
        handle_socket_command(socket_command)

        light = get_light()
        print_formatted_light(light)
        send_notification(light)


if __name__ == "__main__":
    start()
