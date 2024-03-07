return {
    "rcarriga/nvim-dap-ui",
    tag = "v3.9.3",
    dependencies = {
        { "mfussenegger/nvim-dap", tag = "0.7.0" },
        { "leoluz/nvim-dap-go" },
    },
    config = function()
        local dapui = require("dapui")
        local dap = require("dap")

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        require("dap-go").setup()
    end,
}
