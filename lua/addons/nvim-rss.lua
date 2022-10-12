require("nvim-rss").setup{
    feeds_dir = vim.g.data_root..'/rss',
    date_format = "%x %r",
}

vim.cmd [[
command! OpenRssView lua require("nvim-rss").open_feeds_tab()
command! FetchFeed lua require("nvim-rss").fetch_feed()
command! FetchAllFeeds lua require("nvim-rss").fetch_all_feeds()
command! FetchFeedsByCategory lua require("nvim-rss").fetch_feeds_by_category()
command! -range FetchSelectedFeeds lua require("nvim-rss").fetch_selected_feeds()
command! ViewFeed lua require("nvim-rss").view_feed()
command! CleanFeed lua require("nvim-rss").clean_feed()
command! ResetDB lua require("nvim-rss").reset_db()
command! -nargs=1 ImportOpml lua require("nvim-rss").import_opml(<args>)
]]
