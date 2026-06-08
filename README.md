#  nix config

<p>
  <a href="https://github.com/nexvlif/dotfiles"><img alt="Last commit" src="https://img.shields.io/github/last-commit/nexvlif/dotfiles?style=for-the-badge&logo=nixos&color=a6e3a1&logoColor=cdd6f4&labelColor=313244"/></a>
  <a href="https://github.com/nexvlif/dotfiles/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/nexvlif/dotfiles?style=for-the-badge&logo=star&color=f9e2af&logoColor=cdd6f4&labelColor=313244"/></a>
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/github/license/nexvlif/dotfiles?style=for-the-badge&logo=bookstack&color=fab387&logoColor=cdd6f4&labelColor=313244"/></a>
  <a href="https://github.com/nexvlif/dotfiles"><img alt="Repo size" src="https://img.shields.io/github/repo-size/nexvlif/dotfiles?style=for-the-badge&logo=files&color=cba6f7&logoColor=cdd6f4&labelColor=313244"/></a>
</p>

NixOS + home-manager + nixvim config. Single flake for a single machine.

> [!TIP]
> Uses **Lanzaboote** for secure boot, **Hyprland** as the compositor, and **nixvim** for Neovim with 20+ plugins and 14 LSP servers.

---

### Structure

| Path | Description |
|------|-------------|
| `flake.nix` | Flake entry point with all inputs |
| `hosts/nex/` | NixOS configuration for host `nexvlif` |
| `home/` | Home-manager user config |
| `home/editors/nixvim/` | Neovim config (via nixvim) |
| `fmt-hooks.nix` | Pre-commit formatting with treefmt |

### Flake inputs

| Input | Source | Purpose |
|-------|--------|---------|
| `nixpkgs` | `nixos/nixpkgs/nixos-unstable` | Main packages |
| `lanzaboote` | `nix-community/lanzaboote` | Secure boot |
| `flake-parts` | `hercules-ci/flake-parts` | Flake modularization |
| `nixvim` | `nix-community/nixvim` | Neovim packaging |
| `hm` | `nix-community/home-manager` | Home manager |
| `git-hooks` | `cachix/git-hooks.nix` | Pre-commit hooks |
| `treefmt-nix` | `numtide/treefmt-nix` | Code formatters |
| `nuripaper` | `nexvlif/nuripaper` | Wallpaper service |

### Usage

```fish
# rebuild system
sudo nixos-rebuild switch --flake .#nex

# home-manager
home-manager switch --flake .

# dev shell (direnv)
direnv allow
```

### Nixvim

Full Neovim config with:

| Feature | Plugins |
|---------|---------|
| Autocompletion | nvim-cmp, luasnip |
| LSP | 14 servers via mason |
| Formatting | conform.nvim (format on save) |
| Linting | eslint, ruff, statix, selene |
| Fuzzy finding | telescope + fzf-native |
| Git | gitsigns |
| Explorer | oil.nvim |
| Terminal | toggleterm |
| Quick nav | harpoon |

### License

MIT
