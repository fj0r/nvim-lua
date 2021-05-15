let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
let g:asyncrun_open = 6

function! s:lf_task_source(...)
	let rows = asynctasks#source(&columns * 48 / 100)
	let source = []
	for row in rows
		let name = row[0]
		let source += [name . '  ' . row[1] . '  : ' . row[2]]
	endfor
	return source
endfunction


function! s:lf_task_accept(line, arg)
	let pos = stridx(a:line, '<')
	if pos < 0
		return
	endif
	let name = strpart(a:line, 0, pos)
	let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
	if name != ''
		exec "AsyncTask " . name
	endif
endfunction

function! s:lf_task_digest(line, mode)
	let pos = stridx(a:line, '<')
	if pos < 0
		return [a:line, 0]
	endif
	let name = strpart(a:line, 0, pos)
	return [name, 0]
endfunction

function! s:lf_win_init(...)
	setlocal nonumber
	setlocal nowrap
endfunction


let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
let g:Lf_Extensions.task = {
			\ 'source': string(function('s:lf_task_source'))[10:-3],
			\ 'accept': string(function('s:lf_task_accept'))[10:-3],
			\ 'get_digest': string(function('s:lf_task_digest'))[10:-3],
			\ 'highlights_def': {
			\     'Lf_hl_funcScope': '^\S\+',
			\     'Lf_hl_funcDirname': '^\S\+\s*\zs<.*>\ze\s*:',
			\ },
		\ }

let g:asynctasks_template = {}
let g:asynctasks_template.file = [
            \ "[run]",
            \ "command=\"$(VIM_FILEPATH)\"",
            \ "command:c,cpp=\"$(VIM_PATHNOEXT)\"",
            \ "command:go=\"$(VIM_PATHNOEXT)\"",
            \ "command:python=python \"$(VIM_FILENAME)\"",
            \ "command:javascript=node \"$(VIM_FILENAME)\"",
            \ "command:sh=sh \"$(VIM_FILENAME)\"",
            \ "command:lua=luafile \"$(VIM_FILENAME)\"",
            \ "command:perl=perl \"$(VIM_FILENAME)\"",
            \ "command:ruby=ruby \"$(VIM_FILENAME)\"",
            \ "output=terminal",
            \ "cwd=$(VIM_FILEDIR)",
            \ "save=2",
            \ ]
let g:asynctasks_template.cargo = [
            \ "[project-init]",
            \ "command=cargo update",
            \ "cwd=<root>",
            \ "",
            \ "[project-build]",
            \ "command=cargo build",
            \ "cwd=<root>",
            \ "errorformat=%. %#--> %f:%l:%c",
            \ "",
            \ "[project-run]",
            \ "command=cargo run",
            \ "cwd=<root>",
            \ "output=terminal",
            \ ]
let g:asynctasks_template.docker= [
            \ "[build]",
            \ "command=docker build . -t $(VIM_PRONAME):$(?tag:latest)",
            \ "cwd=<root>",
            \ "",
            \ "[run]",
            \ "command=docker run --name $(VIM_PRONAME) --rm -p $(?port:8080):80 $(VIM_PRONAME):$(?tag:latest)",
            \ "cwd=<root>",
            \ "output=terminal",
            \ "",
            \ "[compose]",
            \ "command=docker-compose up",
            \ "cwd=<root>",
            \ "output=terminal",
            \ ]
let g:asynctasks_template.npm= [
            \ "[build]",
            \ "command=npm run build",
            \ "cwd=<root>",
            \ "",
            \ "[run]",
            \ "command=npm start",
            \ "cwd=<root>",
            \ "output=terminal",
            \ "",
            \ "[dev]",
            \ "command=npm run dev",
            \ "cwd=<root>",
            \ "output=terminal",
            \ ]

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

