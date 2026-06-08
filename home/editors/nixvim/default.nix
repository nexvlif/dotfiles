{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    opts = {
      number = true;
      relativenumber = true;

      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;
      autoindent = true;

      cursorline = true;
      colorcolumn = "80";
      wrap = false;
      textwidth = 80;

      hlsearch = true;
      incsearch = true;
      ignorecase = true;
      smartcase = true;

      splitbelow = true;
      splitright = true;

      undofile = true;
      swapfile = false;
      backup = false;

      clipboard = "unnamedplus";

      scrolloff = 8;
      sidescrolloff = 8;

      timeoutlen = 300;
      termguicolors = true;
      mouse = "a";
      signcolumn = "yes";
      encoding = "utf-8";
      hidden = true;
      updatetime = 300;
      completeopt = "menu,menuone,noselect";
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      {
        key = "<C-h>";
        action = "<C-w><C-h>";
        options.desc = "Move focus to left window";
      }
      {
        key = "<C-l>";
        action = "<C-w><C-l>";
        options.desc = "Move focus to right window";
      }
      {
        key = "<C-j>";
        action = "<C-w><C-j>";
        options.desc = "Move focus to lower window";
      }
      {
        key = "<C-k>";
        action = "<C-w><C-k>";
        options.desc = "Move focus to upper window";
      }
      {
        key = "<";
        action = "<gv";
        mode = "v";
        options.desc = "Indent left and re-select";
      }
      {
        key = ">";
        action = ">gv";
        mode = "v";
        options.desc = "Indent right and re-select";
      }
      {
        key = "<A-j>";
        action = ":m .+1<CR>==";
        mode = "n";
        options.desc = "Move line down";
      }
      {
        key = "<A-k>";
        action = ":m .-2<CR>==";
        mode = "n";
        options.desc = "Move line up";
      }
      {
        key = "<A-j>";
        action = ":m '>+1<CR>gv=gv";
        mode = "v";
        options.desc = "Move selection down";
      }
      {
        key = "<A-k>";
        action = ":m '<-2<CR>gv=gv";
        mode = "v";
        options.desc = "Move selection up";
      }
      {
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        options.desc = "Clear search highlights";
      }
      {
        key = "<leader>p";
        action = ''"0p'';
        mode = "n";
        options.desc = "Paste from yank register";
      }
      {
        key = "<leader>P";
        action = ''"0P'';
        mode = "n";
        options.desc = "Paste from yank register above";
      }
      {
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Save file";
      }
      {
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quit";
      }
      {
        key = "<leader>x";
        action = "<cmd>x<CR>";
        options.desc = "Save and quit";
      }
      {
        key = "<leader>bn";
        action = "<cmd>bnext<CR>";
        options.desc = "Next buffer";
      }
      {
        key = "<leader>bp";
        action = "<cmd>bprevious<CR>";
        options.desc = "Previous buffer";
      }
      {
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options.desc = "Delete buffer";
      }
      {
        key = "<Esc>";
        action = "<C-\\><C-n>";
        mode = "t";
        options.desc = "Exit terminal mode";
      }
      {
        key = "<leader>ha";
        action = {
          __raw = "function() require'harpoon':list():add() end";
        };
        options.desc = "Add file to harpoon";
      }
      {
        key = "<leader>hh";
        action = {
          __raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
        };
        options.desc = "Harpoon quick menu";
      }
      {
        key = "<leader>h1";
        action = {
          __raw = "function() require'harpoon':list():select(1) end";
        };
        options.desc = "Navigate to file 1";
      }
      {
        key = "<leader>h2";
        action = {
          __raw = "function() require'harpoon':list():select(2) end";
        };
        options.desc = "Navigate to file 2";
      }
      {
        key = "<leader>h3";
        action = {
          __raw = "function() require'harpoon':list():select(3) end";
        };
        options.desc = "Navigate to file 3";
      }
      {
        key = "<leader>h4";
        action = {
          __raw = "function() require'harpoon':list():select(4) end";
        };
        options.desc = "Navigate to file 4";
      }
    ];

    extraConfigLuaPost = ''
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("AutoCreateDir", { clear = true }),
        callback = function()
          local dir = vim.fn.expand("<afile>:p:h")
          if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
          end
        end,
      })

      vim.api.nvim_create_autocmd("TextYankPost", {
        group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
        callback = function()
          vim.highlight.on_yank({ timeout = 200 })
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>le", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>lE", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, opts)
        end,
      })
    '';

    plugins = {
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "gnn";
              node_incremental = "grn";
              scope_incremental = "grc";
              node_decremental = "grm";
            };
          };
        };
        ensureInstalled = "all";
      };

      telescope = {
        enable = true;
        extensions = {
          "fzf-native".enable = true;
        };
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options.desc = "Find files";
          };
          "<leader>fg" = {
            action = "live_grep";
            options.desc = "Live grep";
          };
          "<leader>fb" = {
            action = "buffers";
            options.desc = "Find buffers";
          };
          "<leader>fh" = {
            action = "help_tags";
            options.desc = "Help tags";
          };
          "<leader>fd" = {
            action = "diagnostics";
            options.desc = "Diagnostics";
          };
          "<leader>fk" = {
            action = "keymaps";
            options.desc = "Keymaps";
          };
          "<leader>fs" = {
            action = "lsp_document_symbols";
            options.desc = "Document symbols";
          };
          "<leader>fr" = {
            action = "lsp_references";
            options.desc = "References";
          };
          "<leader>fc" = {
            action = "commands";
            options.desc = "Commands";
          };
          "gr" = {
            action = "lsp_references";
            options.desc = "References";
          };
          "gd" = {
            action = "lsp_definitions";
            options.desc = "Go to definition";
          };
          "gi" = {
            action = "lsp_implementations";
            options.desc = "Go to implementation";
          };
        };
      };

      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "auto";
            section_separators = "";
            component_separators = "";
          };
        };
      };

      bufferline = {
        enable = true;
        settings = {
          options = {
            mode = "buffers";
            separator_style = "thin";
            always_show_bufferline = true;
            show_buffer_close_icons = true;
            show_buffer_default_icon = true;
          };
        };
      };

      which-key = {
        enable = true;
        settings = {
          spec = [
            {
              __unkeyed = "<leader>f";
              group = "Find";
            }
            {
              __unkeyed = "<leader>b";
              group = "Buffer";
            }
            {
              __unkeyed = "<leader>l";
              group = "LSP";
            }
            {
              __unkeyed = "<leader>g";
              group = "Git";
            }
            {
              __unkeyed = "<leader>s";
              group = "Split";
            }
            {
              __unkeyed = "<leader>t";
              group = "Toggle";
            }
          ];
        };
      };

      cmp = {
        enable = true;
        settings = {
          snippet.expand = "luasnip";
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
      };

      "cmp-nvim-lsp".enable = true;
      cmp_luasnip.enable = true;
      "cmp-path".enable = true;
      "cmp-buffer".enable = true;

      lsp = {
        enable = true;
        keymaps = {
          silent = true;
        };
        servers = {
          nil_ls.enable = true;
          nixd.enable = true;

          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };

          pyright.enable = true;

          ts_ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;

          bashls.enable = true;

          clangd.enable = true;

          gopls.enable = true;

          lua_ls = {
            enable = true;
            settings = {
              Lua = {
                runtime.version = "LuaJIT";
                diagnostics.globals = [ "vim" ];
                workspace.checkThirdParty = false;
              };
            };
          };

          dockerls.enable = true;
          marksman.enable = true;
        };
      };

      mason.enable = true;

      "conform-nvim" = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 1000;
          };
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            lua = [ "stylua" ];
            python = [ "ruff_format" ];
            rust = [ "rustfmt" ];
            go = [ "gofumpt" ];
            javascript = [
              "prettierd"
              "prettier"
            ];
            typescript = [
              "prettierd"
              "prettier"
            ];
            html = [ "prettierd" ];
            css = [ "prettierd" ];
            json = [ "prettierd" ];
            yaml = [ "prettierd" ];
            markdown = [ "prettierd" ];
            sql = [ "sqlfmt" ];
            sh = [ "shfmt" ];
            "_" = [ "trim_whitespace" ];
          };
        };
      };

      lint = {
        enable = true;
        lintersByFt = {
          nix = [ "statix" ];
          python = [ "ruff" ];
          javascript = [ "eslint" ];
          typescript = [ "eslint" ];
          lua = [ "selene" ];
          sh = [ "shellcheck" ];
        };
      };

      trouble = {
        enable = true;
        keymaps = {
          "<leader>xx" = {
            action = "toggle";
            options.desc = "Toggle trouble";
          };
          "<leader>xw" = {
            action = "workspace_diagnostics";
            options.desc = "Workspace diagnostics";
          };
          "<leader>xd" = {
            action = "document_diagnostics";
            options.desc = "Document diagnostics";
          };
          "<leader>xq" = {
            action = "quickfix";
            options.desc = "Quickfix list";
          };
          "<leader>xl" = {
            action = "loclist";
            options.desc = "Location list";
          };
        };
      };

      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
            delay = 200;
          };
          signs = {
            add = {
              text = "+";
            };
            change = {
              text = "~";
            };
            delete = {
              text = "_";
            };
            topdelete = {
              text = "‾";
            };
            changedelete = {
              text = "~";
            };
          };
          on_attach = ''
            function(bufnr)
              local gs = package.loaded.gitsigns

              local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
              end

              map("n", "]c", function()
                if vim.wo.diff then return "]c" end
                vim.schedule(function() gs.next_hunk() end)
                return "<Ignore>"
              end, { expr = true, desc = "Next hunk" })

              map("n", "[c", function()
                if vim.wo.diff then return "[c" end
                vim.schedule(function() gs.prev_hunk() end)
                return "<Ignore>"
              end, { expr = true, desc = "Previous hunk" })

              map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
              map("v", "<leader>gs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, { desc = "Stage hunk" })
              map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
              map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
              map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
              map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
              map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
              map("n", "<leader>gb", function() gs.blame_line { full = true } end, { desc = "Blame line" })
              map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
              map("n", "<leader>gD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
              map("n", "<leader>gt", gs.toggle_deleted, { desc = "Toggle deleted" })

              map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
            end
          '';
        };
      };

      undotree = {
        enable = true;
        keymaps = {
          "<leader>u" = {
            action = "toggle";
            options.desc = "Toggle undotree";
          };
        };
      };

      "nvim-autopairs" = {
        enable = true;
        settings = {
          check_ts = true;
          enable_check_bracket_line = false;
        };
      };

      "nvim-surround".enable = true;

      "indent-blankline" = {
        enable = true;
        settings = {
          indent = {
            char = "│";
            tab_char = "│";
          };
          scope = {
            enabled = true;
            show_start = false;
            show_end = false;
          };
          exclude = {
            filetypes = [
              "help"
              "dashboard"
              "starter"
              "markdown"
              "org"
            ];
            buftypes = [
              "terminal"
              "nofile"
              "quickfix"
              "prompt"
            ];
          };
        };
      };

      comment = {
        enable = true;
        settings = {
          toggler = {
            line = "gcc";
            block = "gbc";
          };
          opleader = {
            line = "gc";
            block = "gb";
          };
        };
      };

      oil = {
        enable = true;
        settings = {
          default_file_explorer = true;
          columns = {
            icon = true;
            permissions = false;
            size = true;
          };
          keymaps = {
            "<C-p>" = false;
            "<C-c>" = false;
          };
        };
        keymaps = {
          "<leader>o" = {
            action = "open";
            options.desc = "Open parent directory";
          };
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          size = 15;
          open_mapping = "[[<leader>tt]]";
          hide_numbers = true;
          shade_terminals = true;
          start_in_insert = true;
          direction = "float";
          float_opts = {
            border = "curved";
          };
        };
        keymaps = {
          "<leader>t1" = {
            action = "1";
            options.desc = "Terminal 1";
          };
          "<leader>t2" = {
            action = "2";
            options.desc = "Terminal 2";
          };
          "<leader>t3" = {
            action = "3";
            options.desc = "Terminal 3";
          };
        };
      };

      harpoon = {
        enable = true;
        settings = {
          menu = {
            width = {
              __raw = "vim.o.columns * 0.6";
            };
            height = {
              __raw = "vim.o.lines * 0.4";
            };
          };
        };
      };

      illuminate = {
        enable = true;
        settings = {
          delay = 200;
          large_file_cutoff = 2000;
          large_file_overrides = {
            providers = [ "lsp" ];
          };
        };
      };

      "todo-comments" = {
        enable = true;
        keymaps = {
          "<leader>ft" = {
            action = "todo";
            options.desc = "Todo comments";
          };
          "<leader>fT" = {
            action = "todo_trouble";
            options.desc = "Todo trouble";
          };
        };
      };
    };
  };
}
