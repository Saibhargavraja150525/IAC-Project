# Server Configuration Automation (Ansible + Python)

Automates web server setup and verifies it afterwards.

## What it does
- `site.yml`: Ansible playbook that installs nginx, deploys a home page from a Jinja2 template,
  and makes sure the service is enabled and running. A handler restarts nginx only when the page changes.
- `scripts/health_check.py`: Python script that checks the HTTP status and response time of servers,
  writes `health_report.json`, and exits with code 1 if any server is unhealthy (useful in pipelines).

## How to run
Prerequisites: Python 3, Ansible (`pip install ansible`), SSH access to a Linux server
(the EC2 instance from the Terraform project works well, or a local VM / WSL / Docker container).

```bash
# 1. Edit inventory.ini with your server IP, user and key
ansible-playbook site.yml --syntax-check
ansible-playbook site.yml --check        # dry run
ansible-playbook site.yml                # apply
ansible-playbook site.yml                # run again: "changed=0" shows it is idempotent

# 2. Verify the result
python3 scripts/health_check.py http://YOUR_SERVER_IP
```

## What I learned
(Add 3 to 4 lines in your own words: idempotency, handlers, templates, inventory, exit codes.)
