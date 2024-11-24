alias vim="nvim"
alias vi="nvim"
alias lg="lazygit"
alias fd="fdfind"

# Update PATH
export PATH="$PATH:/opt/nvim-linux64/bin"

# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)
export FZF_COMPLETION_TRIGGER='**'

# Set zsh theme
ZSH_THEME="powerlevel10k/powerlevel10k"
source $HOME/.p10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # Bazel fzf
# _fzf_complete_bazel_test() {
#     _fzf_complete '-m' "$@" < <(command bazel query \
#         "kind('(test|test_suite) rule', //...)" 2>/dev/null)
# }
#
# _fzf_complete_bazel() {
#     local tokens
#     tokens=($(echo "$COMP_LINE"))
#
#     if [ ${#tokens[@]} -ge 3 ] && [ "${tokens[2]}" = "test" ]; then
#         _fzf_complete_bazel_test "$@"
#     else
#         # Might be able to make this better someday, by listing all repositories
#         # that have been configured in a WORKSPACE.
#         # See https://stackoverflow.com/questions/46229831/ or just run
#         #     bazel query //external:all
#         # This is the reason why things like @ruby_2_6//:ruby.tar.gz don't show up
#         # in the output: they're not a dep of anything in //..., but they are deps
#         # of @ruby_2_6//...
#         _fzf_complete '-m' "$@" < <(command bazel query --keep_going \
#             --noshow_progress \
#             "kind('(binary rule)|(generated file)', deps(//...))" 2>/dev/null)
#     fi
# }
#
# [ -n "$BASH" ] && complete -F _fzf_complete_bazel -o default -o bashdefault bazel
