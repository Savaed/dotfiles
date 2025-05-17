#!/bin/env sh

hyprctl keyword general:cursor_inactive_timeout 1
hyprlock
hyprctl keyword general:cursor_inactive_timeout 0
