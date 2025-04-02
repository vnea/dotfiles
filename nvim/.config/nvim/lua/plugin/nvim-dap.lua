return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        { "mfussenegger/nvim-dap" },
        { "nvim-neotest/nvim-nio" },
        { 'Weissle/persistent-breakpoints.nvim' },

        -- Languages
        { 'mfussenegger/nvim-dap-python' },
        { "leoluz/nvim-dap-go" },
    },
    config = function()
        require("dapui").setup()
        require("dap-python").setup("uv")
        require("dap-go").setup()

        require("persistent-breakpoints").setup({ load_breakpoints_event = { "BufReadPost" } })

        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "➜", texthl = "DiagnosticWarn", linehl = "", numhl = "" })

        -- Start / Stop
        vim.keymap.set("n", "<F9>", function() require("dap").continue() end, { desc = "Start or continue debugging" })
        vim.keymap.set("n", "<leader><F2>", function() require("dap").terminate() end, { desc = "Terminate debugging session" })

        -- Breakpoint
        vim.keymap.set("n", "<leader>b", function() require("persistent-breakpoints.api").toggle_breakpoint() end, { desc = "Toggle breakpoint" })

        -- Steps
        vim.keymap.set("n", "<F8>", function() require("dap").step_over() end, { desc = "Step over" })
        vim.keymap.set("n", "<F7>", function() require("dap").step_into() end, { desc = "Step into" })
        vim.keymap.set("n", "<F6>", function() require("dap").step_out() end, { desc = "Step out" })

        -- UI
        vim.keymap.set("n", "<leader><F9>", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })
    end,
}
