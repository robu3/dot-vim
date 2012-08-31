" unity3d.vim: A vim plugin for Unity (http://unity3d.com/) game devs
" Author: robu
" URL: TBD
" Version: 0.1

" check if already loaded
if (exists("g:loaded_unity3d"))
	finish
endif
let g:loaded_unity3d = 1

" key mappings
map <silent> <leader>ua :call <SID>UnityApi()<CR>
map <silent> <leader>uc :call <SID>CSharpMethodDoc()<CR>
map <silent> <leader>unb :call <SID>NewMonobehavior()<CR>

" look up cursor word in the unity api docs
" thanks to bryant hankins and his aspnetide plugin https://github.com/bryanthankins/vim-aspnetide for giving me this idea
function! s:UnityApi()
	let cword = expand("<cword>")
	let url = "http://unity3d.com/support/documentation/ScriptReference/30_search.html?q=" . cword 
	let cmd = ":silent ! start " . url
	execute cmd
endfunction

" [:space:]*(private|protected|public|static|abstract)*[:space:]+[:identifier:]+\([:params:]\)
let csharp_method = '\s*(public|private)\s?(static|abstract|virtual)?\s?(\w*) (\w*)\s?\((.*)\)'
" [:typehint:]*[:space:]*$[:identifier]\([:space:]*=[:space:]*[:value:]\)?
let csharp_method_param = ' *\([^ &]*\) *&\?\$\([A-Za-z_][A-Za-z0-9_]*\) *=\? *\(.*\)\?$'

function! s:NewMonobehavior()
	execute "normal Ousing UnityEngine;"
	execute "normal ousing System.Collections;\n"
	
	execute "normal opublic class NewBehaviourScript : MonoBehaviour {\n"

	execute "normal o	// Use this for initialization"
	execute "normal o	void Start () {\n"
	
	execute "normal o	}\n"
	
	execute "normal o	// Update is called once per frame"
	execute "normal o	void Update () {\n"
	
	execute "normal o	}"
	execute "normal o}"
endfunction

function! s:CSharpPropertyDoc()
	" insert text one line up
	execute "normal O/// <summary>\n/// \n/// </summary>"
	execute "normal j"
endfunction

" create xml comments for the method defined in the cursor line
function! s:CSharpMethodDoc() 
	" check if the cursor is on a method def
	let matches = matchlist(getline("."), '\s*\(.*\)(\(.*\)).*')
	if len(matches) > 0
		" insert text one line up
		execute "normal O/// <summary>\n/// \n/// </summary>"
		execute "normal j"

		if strwidth(matches[2]) > 0
			"echo "here: " . matches[2]
			" we have method params
			" parse out parameter names
			let params = split(matches[2], ',')
			normal k

			"echo params 
			" param elements
			let i = 0
			let paramCount = 0
			while i < len(params)
				if len(params[i]) > 0
					execute 'normal o/// <param type="' . matchlist(params[i], '\(\w\+\) \w\+')[1] . '" name="' . matchlist(params[i], '\w\+ \(\w\+\)')[1] .'"></param>'
					let paramCount = paramCount + 1
				endif
				let i = i + 1
			endwhile

			" move cursor up
			execute "normal " . (1 + paramCount) . "k"
		endif
	else
		call s:CSharpPropertyDoc()
	endif
endfunction

