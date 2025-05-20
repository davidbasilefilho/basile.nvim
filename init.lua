require("config.set")
require("config.lazy")
if vim.g.vscode then
  require("config.vscode.remap")
else
  require("config.remap")
  require("config.theme")
end