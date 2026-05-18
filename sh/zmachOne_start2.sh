#!/bin/bash
tmux new-session -d -s sinstalling '/home/$USER/machina/sh/zmachOne_principal.sh; exec $SHELL'
