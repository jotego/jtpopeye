#!/bin/bash
quartus_pgm -c '$(quartus_pgm -l | grep -o "USB-Blaster.*")' jtpopeye.cdf