local mapping = require("mapping.module")

-- Toggle open/close tree explorer
mapping.nnoremap("<A-&>", ":Fern . -drawer -toggle<CR>")
