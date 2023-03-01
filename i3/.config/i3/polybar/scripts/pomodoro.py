#!/usr/bin/env python3

import socket
import time
from math import floor
from pathlib import Path


# noinspection PyAttributeOutsideInit
class PomodoroSocket:
    SOCKET_FILE_PATH = "/tmp/pomodoro.sock"

    DEFAULT_WORK_PERIOD_MIN = 15
    ONE_MINUTE_IN_SECONDS = 60
    SIXTY_MINUTES_IN_SECONDS = 3600

    def __init__(self):
        self.work_period_sec = PomodoroSocket.DEFAULT_WORK_PERIOD_MIN * PomodoroSocket.ONE_MINUTE_IN_SECONDS
        self._reset_handler()

    def _reset_handler(self):
        self.reset = True
        self.paused = True
        self.ended = False
        self.time_left_sec = self.work_period_sec

    def _toggle_pause_handler(self):
        if not self.ended:
            self.reset = False
            self.paused = not self.paused

    def _increase_work_period(self):
        if not self.ended:
            self.time_left_sec = min(PomodoroSocket.SIXTY_MINUTES_IN_SECONDS, self.time_left_sec + 30)

    def _decrease_work_period(self):
        if not self.ended and self.time_left_sec > 30:
            self.time_left_sec -= 30

    def _handle_pomodoro_socket_command(self, pomodoro_socket_command):
        match pomodoro_socket_command:
            case b"toggle_pause":
                self._toggle_pause_handler()
            case b"reset":
                self._reset_handler()
            case b"increase_work_period":
                self._increase_work_period()
            case b"decrease_work_period":
                self._decrease_work_period()

    def start(self):
        with socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM) as pomodoro_socket:
            Path(PomodoroSocket.SOCKET_FILE_PATH).unlink(missing_ok=True)
            pomodoro_socket.bind(PomodoroSocket.SOCKET_FILE_PATH)
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
                    icon = ""
                elif self.paused:
                    icon = ""
                elif time_left_sec_without_decimal > 0:
                    icon = "" if seconds % 2 == 0 else ""
                else:
                    self.ended = True
                    icon = ""

                print(f"{icon} {minutes:02d}:{seconds:02d}", flush=True)

                time.sleep(sleep_time_sec)


if __name__ == "__main__":
    pomodoroSocket = PomodoroSocket()
    pomodoroSocket.start()
