#!/bin/bash

grim ~/Pictures/lockscreen/screenshot.png -q 100 && convert -blur 18,4 ~/Pictures/lockscreen/screenshot.png ~/Pictures/lockscreen/screenshot.png

swaylock -i ~/Pictures/lockscreen/screenshot.png
