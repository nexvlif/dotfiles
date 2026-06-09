{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      cmp.enable = true;
      gitsigns.enable = true;
      oil.enable = true;
      nvim-autopairs-enable = true;
    };
  };
}
