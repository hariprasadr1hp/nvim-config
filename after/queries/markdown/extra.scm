;;; after/queries/markdown/extra.scm

(section
  (atx_heading
    [
      (atx_h1_marker)
      (atx_h2_marker)
      (atx_h3_marker)
      (atx_h4_marker)
      (atx_h5_marker)
      (atx_h6_marker)
    ] @marker
    (inline) @text)) @section

(fenced_code_block
  (fenced_code_block_delimiter)
  (info_string
    (language)@language)@code_snippet_args
    (code_fence_content)@code)@code_snippet

