#!venv python
import subprocess

# setting up ansible environment roles for the first time
cmd = "ansible-galaxy install -r requirements.yml"
output = subprocess.check_output(cmd.split())
print(output)
