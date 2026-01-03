# Connect to the systemd-managed ssh-agent (User Scope)
if test -z "$SSH_AUTH_SOCK"
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
end
