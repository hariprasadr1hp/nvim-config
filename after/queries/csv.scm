;; tree-sitter query for CSV syntax highlighting in "rainbow" format
;; This assumes a basic CSV grammar where the structure is understood as rows and columns.
;; Each column will have a unique highlighting group for distinguishing colors.

;; Match each cell in a row
(row (cell) @column_1)
(row (cell) @column_2)
(row (cell) @column_3)
(row (cell) @column_4)
(row (cell) @column_5)
(row (cell) @column_6)
(row (cell) @column_7)
(row (cell) @column_8)
(row (cell) @column_9)

