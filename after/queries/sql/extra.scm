;;; after/queries/sql/extra.scm

;; list all CTE
(cte
  alias_name: (identifier) @cte_names)

;; list all upstream tables
(from_clause
  (from_item) @upstream_tables)

