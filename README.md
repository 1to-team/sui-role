Sui fullnode role
=========

An Ansible role to deploy [Sui fullnode](https://sui.io) was created for our https://nod.run project but it can also be used standalone

Usage Example
----------------
To install:
```bash
./deploy.sh --ip 1.2.3.4 --password supersecret
```

To remove:
```bash
./deploy.sh --ip 1.2.3.4 --password supersecret --action remove
```
WARNING: Backup you private keys before removing a node.

To stop:
```bash
./deploy.sh --ip 1.2.3.4 --password supersecret --action stop
```

Role Variables
--------------
You can see all variables and their descriptions in `defaults/main.yml` file.

To pass variables you can use --extra argument in deploy script:
```bash
./deploy.sh --ip 1.2.3.4 --password supersecret --extra "sui_json_rpc_port=9001 sui_version=main"
```


License
-------
Apache-2.0

Author Information
------------------
https://nod.run
