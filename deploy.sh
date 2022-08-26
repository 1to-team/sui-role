#!/bin/sh
ip=
port=22
user="root"
password=
action="install"
extra=

die() {
    printf '%s\n' "$1" >&2
    exit 1
}

while :; do
    case $1 in
        -i|--ip)
            ip=$2
            shift
            ;;
        -p|--port)
            port=$2
            shift
            ;;
        -u|--user)
            user=$2
            shift
            ;;
        --password)
            password=$2
            shift
            ;;
        -a|--action)
            action=$2
            shift
            ;;
        --extra-vars)
            extra=$2
            shift
            ;;
        --)
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)
            break
    esac
    shift
done
if [ -z "$ip" ]; then
    die 'ERROR: "--ip" argument is required'
fi
if [ -z "$password" ]; then
    die 'ERROR: "--password" argument is required'
fi

ansible-galaxy install -r requirements.yml || die "ERROR: could not install ansible requirements"

cat >inventory <<EOL
[hosts]
$ip ansible_user=$user ansible_password="$password" ansible_port=$port
EOL

cat >playbook.yml <<EOL
---
- hosts: all
  roles:
    - role: '{{ playbook_dir }}'
EOL

ansible-playbook -i inventory --become -v --extra-vars "role_action=${action} ${extra}" playbook.yml
