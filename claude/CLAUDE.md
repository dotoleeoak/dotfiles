## Rules

- Always use English in any responses, unlesss there's explicit order.
- Exceptionally prefer Korean when writing markdown like README.md.
- Rather than guessing specs/features, check internal source code, which is under ~/Workspace/claude-sources.
- If there's no source code under claude-sources, clone the repo under there unless close-sourced.
- I'm open for discussion, so always prefer asking questions if given prompt is ambiguous. Never make assumptions.
- Use plain language, short sentences, and avoid dense or overly compressed phrasing.

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
- Keep the memory index(MEMORY.md) minimal. The index should be a list pointing to other files, and those store all the details.
- Try to organize MEMORY.md by grouping similar memories into sections.

## Current Project

- I'm working on opearating production Ceph cluster.
- I focus on opearating Ceph with reliability and high performance, trying to automate troubleshooting, deloyment, etc.
