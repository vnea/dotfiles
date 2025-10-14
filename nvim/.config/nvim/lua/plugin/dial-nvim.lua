return {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group {
            default = {
                -- Ansible
                augend.constant.new { elements = { "present", "absent" } },

                -- Azure
                augend.constant.new { elements = { "Contributor", "Reader" } },

                -- Bool
                augend.constant.alias.bool,
                augend.constant.new { elements = { "True", "False" } },
                augend.constant.new { elements = { "Yes", "No" } },
                augend.constant.new { elements = { "yes", "no" } },

                -- Date
                augend.date.alias["%H:%M"],
                augend.date.alias["%H:%M:%S"],
                augend.constant.new { elements = { "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche" } },
                augend.constant.new { elements = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" } },

                -- Kubernetes
                augend.constant.new { elements = { "IfNotPresent", "Always", "Never" } },
                augend.constant.new { elements = { "Exact", "ImplementationSpecific", "Prefix" } },
                augend.constant.new { elements = { "ReadWriteOnce", "ReadOnlyMany", "ReadWriteMany", "ReadWriteOncePod" } },

                -- Network Security Rule
                augend.constant.new { elements = { "Inbound", "Outbound"} },
                augend.constant.new { elements = { "Allow", "Deny"} },

                -- Numbers
                augend.integer.alias.decimal_int,
                augend.semver.alias.semver,

                -- Operators
                augend.constant.new { elements = { "eq", "ne" }, word = true },
                augend.constant.new { elements = { "gt", "lt" }, word = true },
                augend.constant.new { elements = { "ge", "le" }, word = true },
                augend.constant.new { elements = { "and", "or" }, word = true },
                augend.constant.new { elements = { "&&", "||" }, word = false },
                augend.constant.new { elements = { ">", "<" }, word = false },
                augend.constant.new { elements = { ">=", "<=" }, word = false },
                augend.constant.new { elements = { "==", "!=" }, word = false },

                -- Others
                augend.constant.new { elements = { "primary", "secondary" }, word = false },
                augend.constant.new { elements = { "stable", "test" } },
                augend.constant.new { elements = { "DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL" } },
                augend.constant.new { elements = { "debug", "info", "warning", "error", "critical" } },
                augend.constant.new { elements = { "api", "front", "cronjob" } },
            },
        }

        vim.keymap.set("n", "<C-a>", function() require("dial.map").manipulate("increment", "normal") end)
        vim.keymap.set("n", "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end)
        vim.keymap.set("v", "<C-a>", function() require("dial.map").manipulate("increment", "visual") end)
        vim.keymap.set("v", "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end)
    end,
}
