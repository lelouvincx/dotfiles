# Agent lifecycle

From the repository root, run `./.agents/setup`, `./.agents/resume` or `./.agents/sync`.
The hooks resolve paths independently of the caller's working directory.
Each entrypoint prepares the required shared runtime before running `.agents/project` with the matching stage.
Shared-runtime failures stop project work and propagate their exit status.

The bootstrap selects the first applicable agent-skills checkout:

1. nonempty `AGENT_SKILLS_DIR`
2. existing `/home/user/workspace/repos/agent-skills`
3. existing sibling `agent-skills`
4. `/home/user/workspace/agent-skills`, cloned only when absent

`AGENT_SKILLS_REPO` overrides the clone URL.
An invalid selected candidate fails rather than falling through or replacing files.
Normal Git roots and linked worktrees are supported; repository subdirectories are not.
Existing duplicate checkouts remain untouched.

Only canonical agent-skills hooks refresh source and project the runtime.
They refresh clean source once and skip pulls for tracked, staged or untracked changes.
Setup uses the shared setup hook; resume and explicit sync use the shared resume hook without setup installers.
Output identifies the source revision and project extension.

Dotfiles currently has no runtime customizations or app work.
These hooks never run `install.sh` or Stow and do not install workstation dotfiles.
Keep workstation installation separate.

Put future runtime customizations in `.agents/project`, after the shared baseline and before stage-specific app work.
Customizations must be idempotent and preserve unrelated runtime files.
Removing a baseline override restores the baseline on the next projection.
Explicitly remove files created only by a retired customization; there is no automatic overlay cleanup.
Explicit sync must not run app work.

## Offline checks

Run `bash .agents/test-lifecycle`.
Set `AGENT_SKILLS_SOURCE` if canonical shared hooks are not in the sibling checkout.
The fixture runs copied public entrypoints with real temporary Git checkouts and mocked projection, installers and app commands.
It relocates fixed Orb candidates into temporary storage and isolates HOME and Git configuration.
It checks checkout precedence, repeated ordering, linked and dirty sources, malformed-path refusal, sync isolation and failure propagation.
It does not prove live Orb setup, pause/wake or settings activation.
