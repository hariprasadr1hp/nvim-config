;; extends

; Inject JavaScript in inline ${ ... }
((ERROR) @injection.content
  (#match? @injection.content "\\$\\{[\\s\\S]*\\}")
  (#set! injection.language "javascript"))

; Inject JavaScript in  js { ... }  blocks
((ERROR) @injection.content
  (#match? @injection.content "^\\s*js\\s*\\{[\\s\\S]*\\}")
  (#set! injection.language "javascript"))

; Treat config { ... } like JSONC (JSON with comments)
((ERROR) @injection.content
  (#match? @injection.content "^\\s*config\\s*\\{[\\s\\S]*\\}")
  (#set! injection.language "jsonc"))

