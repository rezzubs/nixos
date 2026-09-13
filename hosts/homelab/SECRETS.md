# Secrets (sops-nix)

Secrets for this host are managed with
[sops-nix](https://github.com/Mic92/sops-nix) and live encrypted in
`secrets.yaml`, next to `configuration.nix`.

## Recipients

`secrets.yaml` is encrypted to two **age** recipients, declared in `.sops.yaml`
at the repo root:

- **homelab's own SSH host key** (`/etc/ssh/ssh_host_ed25519_key`, converted to
  age) — lets the host decrypt its own secrets automatically at activation, no
  manual step.
- **A personal admin age key**, generated once and kept outside this repo. This
  makes secrets recoverable after a full reinstall when the host key changes.

## Initial bootstrap (fresh checkout / fresh host)

1. Generate the personal key, if you don't already have one:
  ```bash
  nix shell nixpkgs#age -c age-keygen
  ```
  Back the private key up somewhere durable, independent of this repo and of
  homelab.

2. Get homelab's host key and convert it to an age recipient:
  ```bash
  cat /etc/ssh/ssh_host_ed25519_key.pub | nix shell nixpkgs#ssh-to-age -c ssh-to-age
  ```
3. Create `.sops.yaml` at the **repo root**. Sops walks upward from the file
  it's operating on looking for this file
  ```yaml
  creation_rules:
    - path_regex: hosts/homelab/secrets\.yaml$
      key_groups:
        - age:
            - <homelab-host-age-pubkey-from-step-2>
            - <your-personal-age-pubkey-from-step-1>
  ```
  This is what lets `sops hosts/homelab/secrets.yaml` and `sops updatekeys`
  know who to encrypt to, without passing `--age <keys>` by hand every time.

4. Author the secrets file interactively (opens `$EDITOR` on a decrypted scratch
  buffer, encrypts on save):
  ```bash
  nix run nixpkgs#sops hosts/homelab/secrets.yaml
  ```
  `borgmatic.ssh_key` should be a **dedicated** keypair, not reused from
  anywhere else — generate with `ssh-keygen -t ed25519 -N "" -f /tmp/borg_key`,
  paste the private key in, add the `.pub` as an authorized key on the Borgbase
  repo, then delete the temp files.

5. Deploy: `nixos-rebuild switch --flake .#homelab`.

## Recovering after a reinstall

A reinstall generates a brand-new host key, which can't decrypt the old `secrets.yaml`.
The personal key is what makes this recoverable instead of a full secret-regeneration:

1. Get the new host's key and convert it to age (step 2 above).
2. Add it to `.sops.yaml` as a recipient.
3. Re-encrypt using the personal key: `nix shell nixpkgs#sops -c sops updatekeys hosts/homelab/secrets.yaml`.
4. Deploy as normal.

## Adding a new secret

1. `nix run nixpkgs#sops hosts/homelab/secrets.yaml`, add the key under the
   right namespace.
2. In `configuration.nix`, add `sops.secrets."namespace/name"
  = {};` (or extend an existing `sops.templates.*.content` with
  `${config.sops.placeholder."namespace/name"}` if it needs to be combined with
  other values, e.g. into a dotenv-shaped file for docker compose).
3. Point whatever consumes it at `config.sops.secrets."namespace/name".path`.
  Never hardcode a path by hand.
4. If a non-root process needs to read it directly (e.g. a manually-run
   `docker compose --env-file`), set `owner`/`mode` accordingly - sops-nix's default is
   `root:root 0400`.

## Verifying after `nixos-rebuild switch`

- `ls -la /run/secrets/ /run/secrets-rendered/` - expected files, correct owner/mode.
- `systemctl cat borgmatic.service` / `systemctl cat ddclient.service` - confirm the
  secrets are actually wired into the unit.
- `borgmatic config validate` and `borgmatic create --dry-run` - confirm the borgmatic
  env-var expansion resolves.
- `systemctl start ddclient.service && journalctl -u ddclient -e` - confirm the
  Cloudflare update succeeds.
