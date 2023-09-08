#!/usr/bin/bash
# Used to underlock the gpus on the system
# In this case all the gpus are underclocked to resistrict the power they draw
nvidia-smi -pm 1
nvidia-smi -lgc 300,1140
