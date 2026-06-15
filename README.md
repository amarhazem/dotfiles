# Dotfiles

Personal development environment managed with [chezmoi](https://www.chezmoi.io/).

This setup is primarily designed for a Windows + WSL2 development workflow with Ubuntu, Docker Desktop, Cursor, Zsh, Oh My Zsh, Node.js, pnpm, GitHub CLI, and project repositories cloned into a workspace directory.

## Prerequisites

Install the following tools on Windows:

* WSL2 with Ubuntu
* Docker Desktop
* Cursor

Then open an Ubuntu terminal.

## Installation

Run the chezmoi bootstrap command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply amarhazem/dotfiles
```

If chezmoi is already installed, you can use:

```bash
chezmoi init --apply amarhazem/dotfiles
```

The first run will install system packages, configure WSL, install user tools, set up the shell, and prepare the development environment.

Some steps may be skipped during the first run if GitHub CLI is not authenticated yet.

## Restart WSL

After the first `chezmoi apply`, close Ubuntu and run the following command from PowerShell:

```powershell
wsl --shutdown
```

Then reopen Ubuntu.

This is required because the setup modifies `/etc/wsl.conf`. WSL configuration changes only take effect after restarting WSL.

## Authenticate GitHub CLI

In Ubuntu, authenticate GitHub CLI:

```bash
gh auth login --git-protocol ssh
```

Follow the interactive prompts.

You can verify the authentication status with:

```bash
gh auth status
```

## Apply dotfiles again

After GitHub CLI is authenticated, run:

```bash
chezmoi apply --verbose
```

This second run finalizes the setup. It can:

* upload the SSH public key to GitHub;
* clone GitHub repositories into the workspace;
* install editor extensions;
* complete any step that was skipped before authentication.

## Update the environment

To apply future changes:

```bash
chezmoi apply --verbose
```

To inspect changes before applying them:

```bash
chezmoi diff
```

To edit the local chezmoi configuration:

```bash
chezmoi edit-config
```

Local machine-specific values should be stored in the chezmoi config file, not committed to this repository.

## Local configuration

User-specific values can be configured locally with:

```bash
chezmoi edit-config
```

Example:

```toml
[data]
workspace.directory = "workspace"

[data.git.user]
name = "Your Name"
email = "your.email@example.com"
```

These values are local to the machine and are not stored in the repository.

## What this setup installs

The setup can configure and install:

* WSL interoperability settings;
* APT repositories and system packages;
* Git and GitHub CLI;
* Zsh as the default shell;
* Oh My Zsh;
* NVM;
* Node.js LTS;
* Corepack;
* pnpm;
* Yarn;
* Vercel CLI;
* Cursor and/or VS Code extensions;
* SSH key generation;
* GitHub SSH key upload;
* workspace directory creation;
* GitHub repository cloning.

## Recommended onboarding flow

1. Install WSL2/Ubuntu, Docker Desktop, and Cursor.
2. Open Ubuntu.
3. Run the chezmoi bootstrap command.
4. Restart WSL with `wsl --shutdown`.
5. Reopen Ubuntu.
6. Authenticate GitHub CLI with `gh auth login --git-protocol ssh`.
7. Run `chezmoi apply --verbose` again.

## Verification

After installation, you can verify the main tools:

```bash
zsh --version
git --version
gh --version
node --version
npm --version
pnpm --version
yarn --version
docker --version
```
