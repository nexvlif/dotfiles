{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.catppuccin.enable = true;

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          pyright.enable = true;
          ts_ls.enable = true;
        };
      };
      cmp.enable = true;
      gitsigns.enable = true;
      oil.enable = true;
      nvim-autopairs.enable = true;
      web-devicons.enable = true;
      comment.enable = true;
    };

    opts = {
      number = true;
      shiftwidth = 2;
      tabstop = 2;
    };
  };
}
