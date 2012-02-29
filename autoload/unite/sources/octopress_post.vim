" octopress post source for unite.vim
" Version:     0.0.1
" Last Change: 29 Feb 2012
" Author:      choplin <choplin.public+vim@gmail.com>
" Licence:     The MIT License {{{
"     Permission is hereby granted, free of charge, to any person obtaining a copy
"     of this software and associated documentation files (the "Software"), to deal
"     in the Software without restriction, including without limitation the rights
"     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
"     copies of the Software, and to permit persons to whom the Software is
"     furnished to do so, subject to the following conditions:
"
"     The above copyright notice and this permission notice shall be included in
"     all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
"     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
"     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
"     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
"     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
"     THE SOFTWARE.
" }}}

let s:save_cpo = &cpo
set cpo&vim

" define source
function! unite#sources#octopress_post#define()
  return s:source
endfunction

" source
let s:source = {
\ 'name': 'octopress/post',
\ 'description': 'candidate from octopress posts',
\}
function! s:source.gather_candidates(args, context)
  if !exists('g:unite_source_octopress_base_directory')
    let g:unite_source_octopress_base_directory = input('Octopress directory: ', '', 'dir')
  endif

  let files = s:get_files(g:unite_source_octopress_base_directory)

  return map(files, '{
    \ "word" : v:val,
    \ "abbr" : s:get_abbr(v:val),
    \ "kind" : "file",
    \ "action__path" : v:val,
    \ }')
endfunction

function! s:get_files(base)
  let dir = a:base . '/source/_posts/*'
  return split(glob(dir), '\r\n\|\n')
endfunction

function! s:get_abbr(path)
  let fname = fnamemodify(a:path, ':p:t:r')
  let l = split(fname, '-')
  "/yyyy/mm/dd title
  return '/'.l[0].'/'.l[1].'/'.l[2].' '.join(l[3:], '-')
endfunction

call unite#define_source(s:source)

let &cpo = s:save_cpo
unlet s:save_cpo
