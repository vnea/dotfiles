return {
    "CopilotC-Nvim/CopilotChat.nvim",
    build = "make tiktoken",
    opts = {
        mappings = {
            complete = {
                insert = "", -- Trick to be able to use <Tab> (auto completion from Copilot) in the prompt chat
            },
            reset = {
                normal = "<Leader>cc",
                insert = "",
            },
        },
    },
}
