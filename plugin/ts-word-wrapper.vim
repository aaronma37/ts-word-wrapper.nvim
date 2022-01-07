" fun! YourFirstPlugin(pre, post)
"     " dont forget to remove this one....
"     lua for k in pairs(package.loaded) do if k:match("^your%-first%-plugin") then package.loaded[k] = nil end end
"     lua require("your-first-plugin").test(args, args)
" endfun

command! -nargs=* TSWordWrap exe 'lua package.loaded.test = nil' | lua require'ts-word-wrapper'.test(<args>)

augroup YourFirstPlugin
    autocmd!
    autocmd VimResized * :lua require("your-first-plugin").onResize()
augroup END
