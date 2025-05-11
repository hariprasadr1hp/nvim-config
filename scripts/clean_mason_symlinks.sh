#!/bin/bash

MASON_DIR="${HOME}/.local/share/nvim/mason"
SCHEMAS_DIR="$MASON_DIR/share/mason-schemas/lsp"

echo "🔍 Scanning for broken symlinks in: $MASON_DIR"

# 1. Find broken symlinks
broken_symlinks=$(find "$MASON_DIR" -L -type l)

if [ -z "$broken_symlinks" ]; then
	echo "✅ No broken symlinks found."
else
	echo "⚠️ Found broken symlinks:"
	echo "$broken_symlinks"
	echo
	read -p "🧹 Delete these broken symlinks? [y/N]: " confirm
	if [[ "$confirm" =~ ^[Yy]$ ]]; then
		echo "$broken_symlinks" | xargs rm
		echo "✅ Broken symlinks removed."
	else
		echo "❌ No changes made."
	fi
fi

# 2. Clean broken Mason LSP registry JSON links
if [ -d "$SCHEMAS_DIR" ]; then
	broken_jsons=$(find "$SCHEMAS_DIR" -L -type l)

	if [ -n "$broken_jsons" ]; then
		echo
		echo "⚠️ Found broken registry JSON symlinks:"
		echo "$broken_jsons"
		echo
		read -p "🧹 Delete these registry symlinks? [y/N]: " confirm_json
		if [[ "$confirm_json" =~ ^[Yy]$ ]]; then
			echo "$broken_jsons" | xargs rm
			echo "✅ JSON registry symlinks removed."
		else
			echo "❌ Skipped registry cleanup."
		fi
	else
		echo
		echo "✅ No broken JSON registry symlinks."
	fi
fi

echo
echo "🎉 Mason cleanup complete!"
