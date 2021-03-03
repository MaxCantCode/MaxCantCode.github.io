-- load standard vis module, providing parts of the Lua API
require('vis')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('!stty dsusp undef')
	vis:command('se theme nu')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	-- vis:command('set number')
	vis:command('se cul')
	vis:command('se rnu')
	vis:command('unmap normal S')
	vis:command('unmap normal s')
	vis:command('unmap normal O')
	vis:command('map! normal o <vis-prompt-show><Up><Escape>zb')
	vis:command('unmap normal X')
	vis:command('unmap normal x')
	vis:command('map! normal ? <vis-search-forward><Up><Escape>zb')
end)

