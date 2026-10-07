# ansible-lint

Custom `ansible-lint` image with the project's collections preinstalled. Used by Woodpecker CI to lint the `ops` repo without re-installing collections on every run.

## Image

`git.pmon.dev/schnappy/ansible-lint:latest`

Base: `python:3.13-slim` + `git` + `jq` + `ansible-lint` + `hvac` + collections:

- `ansible.posix` (ops's `ansible.builtin.mount` and `synchronize` resolve to it)
- `community.hashi_vault`
- `community.general`
- `kubernetes.core`
- `gluster.gluster`

If a playbook starts using a new collection, add it here and let Woodpecker rebuild the image — don't `ansible-galaxy install` inside the lint step.

## Build

Woodpecker CD builds and pushes on every push to `main` (`.woodpecker/cd.yaml`, Kaniko).

## Usage

The `ops` repo's `.woodpecker/ci.yaml` runs lint with this image:

```yaml
- name: ansible-lint
  image: git.pmon.dev/schnappy/ansible-lint:latest
  commands:
    - ansible-lint deploy/ansible/
```

## Full Infrastructure Docs

See `schnappy/ops` repo `CLAUDE.md`.
