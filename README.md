# ansible-lint

Custom `ansible-lint` image with the project's collections preinstalled, used by Woodpecker CI to lint the ops repo without re-installing dependencies on every run.

## Contents

- `ansible-lint`
- `hvac` (Vault module)
- Collections: `community.hashi_vault`, `community.general`, `kubernetes.core`, `gluster.gluster`

## Usage

Built by Woodpecker CI and pushed to `git.pmon.dev/schnappy/ansible-lint`. The ops repo's `.woodpecker/ci.yaml` uses this image for the `ansible-lint` step.
