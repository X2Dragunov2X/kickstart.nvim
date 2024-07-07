return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED 
    harpoon:setup()
    -- REQUIRED

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<leader>a', function() harpoon:list():add()    end,          { desc = '[a]dd file to harpoon' })
    vim.keymap.set('n', '<leader>A', function() harpoon:list():remove() end,          { desc = '[A] remove file from harpoon]' })
    vim.keymap.set('n', '<C-e>',     function() toggle_telescope(harpoon:list()) end, { desc = 'Open harpoon window' })

    vim.keymap.set('n', '<C-h>',     function() harpoon:list():select(1) end,         { desc = '[a]dd file to harpoon' })
    vim.keymap.set('n', '<C-t>',     function() harpoon:list():select(2) end,         { desc = '[a]dd file to harpoon' })
    vim.keymap.set('n', '<C-n>',     function() harpoon:list():select(3) end,         { desc = '[a]dd file to harpoon' })
    vim.keymap.set('n', '<C-s>',     function() harpoon:list():select(4) end,         { desc = '[a]dd file to harpoon' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-p>',     function() harpoon:list():prev() end,            { desc = '[a]dd file to harpoon' })
    vim.keymap.set('n', '<C-n>',     function() harpoon:list():next() end,            { desc = '[a]dd file to harpoon' })
  end,
}