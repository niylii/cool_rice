
-- Find Word                    <C-n>                        |vm-find-word|
-- Next/Previous/Skip           n / N / q                    |vm-find-next|
-- Remove Region                Q                            |vm-remove-region|
-- Add Cursors Down/Up          <C-Down> / <C-Up>            |vm-add-cursors|
-- Add Cursor at Position       \\\                          |vm-add-cursor|
-- Select Right/Left            <S-Right>, <S-Left>          |vm-shift-select|
-- Select All Words             \\A                          |vm-select-all|
-- Slash motion                 g/                           |vm-slash|
-- Find with Regex              \\/                          |vm-regex-search|
-- Reselect Last                \\gS                         |vm-reselect-last|
-- Toggle Mappings              \\<Space>                    |vm-mappings-toggle|
-- Select Operator              s                            |vm-select-operator|
-- Find Operator                m                            |vm-find-operator|
-- Alignment                    \\a                          |vm-align|
-- Transposition                \\t                          |vm-transpose|
return {
	{
		"mg979/vim-visual-multi",
		branch = "master",
		event = { "VeryLazy" },
		init = function()
			vim.g.VM_default_mappings = 1
		end,
		config = function()
			vim.g.VM_maps = {
				["Find Under"] = "<C-n>",
				["Find Subword Under"] = "<C-n>",
			}
		end,
	},
}
