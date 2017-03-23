import subprocess
import os

# Run single git command
def git(cmd, args=[], stdin=None, stderr=None, shell=False, universal_newlines=False):
    try:
        return subprocess.check_output(["git", cmd] + args, stdin=stdin, stderr=stderr, shell=shell, universal_newlines=universal_newlines)
    except:
        return None

# Get list of all branches in current directory
def branches(include_asterisk=False):
    branches_with_asterisk = [line.strip() for line in git("branch").splitlines()]
    if include_asterisk:
        return branches_with_asterisk
    else:
        branches_without_asterisk = list(branches_with_asterisk)
        for idx, branch in enumerate(branches_with_asterisk):
            if branch.startswith("* "):
                branches_without_asterisk[idx] = branch[2:]
        return branches_without_asterisk

# Get current active git branch
def current_branch():
    return next(b[2:] for b in branches(True) if b.startswith("*"))

# Get branch's upstream (or current branch if None)
def upstream(branch=None):
    tmp = current_branch()

    cmd = "rev-parse"
    args = ["--abbrev-ref", "--symbolic-full-name", "@{upstream}"]

    git("checkout", [branch, "-q"])

    cmd = "rev-parse"
    args = ["--abbrev-ref", "--symbolic-full-name", "@{upstream}"]
    possible_upstream = git(cmd, args, None, open(os.devnull, "wb"), False, False)
    if possible_upstream:
        possible_upstream = possible_upstream.strip()

    git("checkout", [tmp, "-q"])

    return possible_upstream
