return {
    "monaqa/dial.nvim",
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group {
            default = {
                -- Numbers
                augend.integer.alias.decimal_int,
                augend.semver.alias.semver,

                -- Date
                augend.date.alias["%H:%M"],
                augend.date.alias["%H:%M:%S"],
                augend.constant.new { elements = { "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche" } },
                augend.constant.new { elements = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" } },

                -- Bool
                augend.constant.alias.bool,
                augend.constant.new { elements = { "present", "absent" } },
                augend.constant.new { elements = { "True", "False" } },
                augend.constant.new { elements = { "Yes", "No" } },
                augend.constant.new { elements = { "yes", "no" } },

                -- Operators
                augend.constant.new { elements = { "eq", "ne" }, word = true },
                augend.constant.new { elements = { "gt", "lt" }, word = true },
                augend.constant.new { elements = { "ge", "le" }, word = true },
                augend.constant.new { elements = { "and", "or" }, word = true },
                augend.constant.new { elements = { "&&", "||" }, word = false },
                augend.constant.new { elements = { ">", "<" }, word = false },
                augend.constant.new { elements = { ">=", "<=" }, word = false },
                augend.constant.new { elements = { "==", "!=" }, word = false },
            },
        }

        vim.keymap.set("n", "<C-a>", function() require("dial.map").manipulate("increment", "normal") end)
        vim.keymap.set("n", "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end)
        vim.keymap.set("v", "<C-a>", function() require("dial.map").manipulate("increment", "visual") end)
        vim.keymap.set("v", "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end)
    end,
}
