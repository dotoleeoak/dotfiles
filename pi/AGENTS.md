## Rules

- Always use English in any responses, unlesss there's explicit order.
- Exceptionally prefer Korean when writing markdown like README.md.
- Rather than guessing specs/features, check internal source code, which is under ~/Workspace/claude-sources.
- If there's no source code under claude-sources which open-sourced, you can freely clone one under there.
- I'm open for discussion, so always prefer asking questions if given prompt is ambiguous. Never make assumptions.
- Give concise answer with key points, avoid verbosity. If you're not sure what to do or answer, give questions.

## Coding

- Testing is always fundamental to writing code. Rather than writing all the code at once, do test after each step of implementation.
- Simplicity is always first. When the logic gets messy, always review if simpler approach exists.
- In comments, write 'why' this is implemented this way, rather than 'what' this part of code does.

## Code Reading Workflow

- For source inspection tasks, clone the repo locally under `/tmp/agent-repos` if it is not already present.
- Prefer local inspection with `rg`, `fd`, `git grep`, `git diff`, and `sed`.
- Use `gh` only for release notes, PRs, issues, tags, and repository metadata.
- Avoid GitHub code search when a local clone can answer the question.
- When possible, checkout the exact release tag/branch before reading code.

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
