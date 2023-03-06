#!/usr/bin/env python3

import subprocess
import time
from math import floor
from socket import socket, AF_INET, SOCK_DGRAM


# noinspection PyAttributeOutsideInit
class PomodoroSocket:
    SOCKET_FILE_PATH = "/tmp/pomodoro.sock"

    DEFAULT_WORK_PERIOD_MIN = 15
    ONE_MINUTE_IN_SECONDS = 60
    SIXTY_MINUTES_IN_SECONDS = 3600

    RESET_ICON = '🍅'
    PAUSE_ICON = '⏸️'
    RUNNING_1_ICON = '⌛'
    RUNNING_2_ICON = '⏳'
    END_ICON = '⏰'

    def __init__(self):
        self.work_period_sec = PomodoroSocket.DEFAULT_WORK_PERIOD_MIN * PomodoroSocket.ONE_MINUTE_IN_SECONDS
        self._reset_handler()

    def _reset_handler(self):
        self.reset = True
        self.paused = True
        self.ended = False
        self.end_notification_sent = False
        self.time_left_sec = self.work_period_sec

    def _toggle_pause_handler(self):
        if not self.ended:
            self.reset = False
            self.paused = not self.paused

    def _increase_timer(self):
        if not self.ended:
            self.time_left_sec = min(PomodoroSocket.SIXTY_MINUTES_IN_SECONDS, self.time_left_sec + 30)

    def _decrease_timer(self):
        if not self.ended:
            if self.time_left_sec > 30:
                self.time_left_sec -= 30
            elif 5 < self.time_left_sec <= 30:
                self.time_left_sec -= 5

    def _send_end_notification(self):
        subprocess.Popen([
            "dunstify",
            "--appname",
            "🍅 Pomodoro 🍅",
            "--timeout",
            "5000",
            "Time's up, who's next?!"
        ])
        subprocess.Popen(
            ["play", "~/bootsrap-poste/i3/.config/i3/polybar/scripts/pomodoro/time-s-up.mp3"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
        self.end_notification_sent = True

    def _handle_pomodoro_socket_command(self, pomodoro_socket_command):
        match pomodoro_socket_command:
            case b"toggle_pause":
                self._toggle_pause_handler()
            case b"reset":
                self._reset_handler()
            case b"increase_timer":
                self._increase_timer()
            case b"decrease_timer":
                self._decrease_timer()

    def start(self):
        pomodoro_socket = socket(AF_INET, SOCK_DGRAM)
        pomodoro_socket.bind(("127.0.0.1", 60002))
        pomodoro_socket.setblocking(False)

        sleep_time_sec = 0.100

        while True:
            try:
                pomodoro_socket_command, _ = pomodoro_socket.recvfrom(1024)
                self._handle_pomodoro_socket_command(pomodoro_socket_command)
            except BlockingIOError:
                pass

            if not self.paused and not self.ended:
                self.time_left_sec -= sleep_time_sec

            time_left_sec_without_decimal = floor(self.time_left_sec)
            minutes, seconds = divmod(time_left_sec_without_decimal, PomodoroSocket.ONE_MINUTE_IN_SECONDS)

            if self.reset:
                icon = PomodoroSocket.RESET_ICON
            elif self.paused:
                icon = PomodoroSocket.PAUSE_ICON
            elif time_left_sec_without_decimal > 0:
                icon = PomodoroSocket.RUNNING_1_ICON if seconds % 2 == 0 else PomodoroSocket.RUNNING_2_ICON
            else:
                self.ended = True
                icon = PomodoroSocket.END_ICON
                if not self.end_notification_sent:
                    self._send_end_notification()

            print(f"{icon} {minutes:02d}:{seconds:02d}", flush=True)

            time.sleep(sleep_time_sec)


if __name__ == "__main__":
    pomodoroSocket = PomodoroSocket()
    pomodoroSocket.start()
