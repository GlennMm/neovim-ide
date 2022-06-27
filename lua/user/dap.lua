local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end



local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end


dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    -- You can change the order of elements in the sidebar
    {
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        {
          id = "scopes",
          size = 0.15, -- Can be float or integer > 1
        },
        { id = "breakpoints", size = 0.25 },
        -- { id = "stacks", size = 0.25 },
        -- { id = "watches", size = 00.25 },
      },
      size = 40,
      position = "right", -- Can be "left", "right", "top", "bottom"
    },
    {
      elements = {
        "repl",
        "console"
      },
      size = 40,
      position = 'bottom'
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

local icons = require "user.icons"

vim.fn.sign_define('DapBreakpoint', {text=" ", texthl='DiagnosticSignError', linehl='', numhl=''})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local os = require("os")
--
-- python adapters and configurations
dap.adapters.python = {
  type = 'executable',
  command = os.getenv('HOME')..'/anaconda3/bin/python',
  args = { '-m', 'debugpy.adapter' }
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch File',
    program = "${file}",
    pythonPath = os.getenv('HOME')..'/anaconda3/bin/python'
  }
}

-- node adapter and configurations
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME')..'/.debug/dap/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    name = "Npm dev",
    type = 'node2',
    request =  'launch',
    runtimeExecutable = 'yarn',
    cwd = "${workspaceFolder}",
    runtimeArgs = {'dev'},
    port = 5858
  },
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

-- go adapter and configurations
dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = {os.getenv('HOME') .. '/.debug/dap/vscode-go/dist/debugAdapter.js'};
}
dap.configurations.go = {
  {
    type = 'go';
    name = 'Debug';
    request = 'launch';
    showLog = false;
    program = "${file}";
    dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
  },
}

-- dart adapter and configurations
dap.adapters.dart = {
  type = "executable",
  command = "node",
  args = { os.getenv('HOME').."/.debug/dap/Dart-Code/out/dist/debug.js", "flutter"}
}
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = os.getenv('HOME').."/flutter/bin/cache/dart-sdk/",
    flutterSdkPath = os.getenv('HOME').."/flutter",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  }
}



