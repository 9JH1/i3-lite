import sys 
import subprocess
import json

def print_line(message):
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def get_line():
    return subprocess.check_output(['/home/_3hy/.config/i3/src/playerctl.sh']).decode().replace("\n","")

def read_line():
    try:
        line = sys.stdin.readline().strip()
        if not line:
            sys.exit(3)
        return line
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    print_line(read_line())
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        j.insert(0, {'full_text' : '%s' % get_line(), 'name' : 'gov'})
        print_line(prefix+json.dumps(j))
