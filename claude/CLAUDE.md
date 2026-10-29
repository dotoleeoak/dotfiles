## Rules

- Always use English in any responses, unlesss there's explicit order.
- Exceptionally prefer Korean when writing markdown like README.md.
- Rather than guessing specs/features, check internal source code, which is under ~/Workspace/claude-sources.
- If there's no source code under claude-sources, clone the repo under there unless close-sourced.
- I'm open for discussion, so always prefer asking questions if given prompt is ambiguous. Never make assumptions.
- Use plain language, short sentences, and avoid dense or overly compressed phrasing.
- Keep responses focused, brief, and concise. Keep disclaimers and caveats short, and spend most of the response on the main answer.

## Coding

- Testing is always fundamental to writing code. Rather than writing all the code at once, do test after each step of implementation.
- Simplicity is always first. When the logic gets messy, always review if simpler approach exists.
- In comments, write 'why' this is implemented this way, rather than 'what' this part of code does.
- Don't write a comment that code already describes. Write comments only when necessary, and keep it minimal.
- Don't commit/push by yourself. I will manually review changes before any commit, and then commit/push by myself.

## Tools

- When using Bash for file/content searches, use ripgrep(`rg`) instead of `grep`, and fdfind(`fd`) instead of`find`.
- Whenever you need to update Dooray task, don't use the content you've read before. That's outdated, always read first.

## Memory

- Aggressively save new things you've learned in this session to memory. Memory helps you skip redundant tool usage and save time.
- One global store at `~/.claude/memory/` serves every project. Repo-only memory goes under `projects/<repo>/`; everything else goes by topic.
- Memory is a tree, not one flat file: `MEMORY.md` → `<topic>/index.md` → `<topic>/<sub>/index.md` → memory files.
- `MEMORY.md` lists only top-level topic dirs, one line each. Touch it only when adding or renaming a top-level dir.
- Each dir has its own `index.md` with one line per memory or sub-dir. A new memory goes into the best-matching dir and is listed in that dir's `index.md` only.
- Sub-indexes are not auto-loaded. Read the relevant `index.md` before working in an area, and before saving, to avoid duplicates.
- Split a dir into sub-dirs once its `index.md` passes about 30 lines.

@CLAUDE.local.md
