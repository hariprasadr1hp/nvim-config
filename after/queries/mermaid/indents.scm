; after/queries/mermaid/indents.scm

;; Indent the attributes inside entity blocks
(er_stmt_entity_block_inner) @indent
(er_attribute) @indent

;; Indent the whole diagram (optional)
(diagram_er) @indent

;; Align entity relationships
(er_stmt_entity_relation) @align

;; Indent inside top-level diagram_er (root node)
(diagram_er) @indent
