import subprocess
import os

NO_UPSTREAM = "{NO_UPSTREAM}"
REMOTE = "{REMOTE}"

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

    if branch:
        git("checkout", [branch, "-q"])

    cmd = "rev-parse"
    args = ["--abbrev-ref", "--symbolic-full-name", "@{upstream}"]
    possible_upstream = git(cmd, args, None, open(os.devnull, "wb"), False, False)
    if possible_upstream:
        possible_upstream = possible_upstream.strip()

    if branch:
        git("checkout", [tmp, "-q"])

    return possible_upstream

# Return all upstreams in a dict (fewer subprocess calls than
# calling upstream(branch) for all branches. Upstream name can
# be "{NO_UPSTREAM}" or "{REMOTE}" for those cases.
def upstreams():
    # Exclude remote HEAD
    verbose_all_branches = [l.strip() for l in git("branch", ["-avv"]).splitlines() if "HEAD" not in l]

    all_upstreams = {}
    for verbose_branch in verbose_all_branches:
        verbose_branch_info = verbose_branch.split()

        name_idx = 1 if verbose_branch_info[0] == "*" else 0

        branch_name = verbose_branch_info[name_idx]

        possible_upstream_name = verbose_branch_info[name_idx+2][1:-1]

        upstream_name = None
        if verbose_branch_info[name_idx+2].startswith("["):
            # Regular upstream
            upstream_name = possible_upstream_name
        elif branch_name.startswith("remotes"):
            # Remote branch, no upstream
            branch_name = branch_name[8:]
            upstream_name = REMOTE
        else:
            # Local branch, no upstream
            upstream_name = NO_UPSTREAM

        all_upstreams[branch_name] = upstream_name

    return all_upstreams

# Return list of all remote branch names
def remotes():
    # Exclude remote HEAD
    verbose_remote_branches = [l.strip() for l in git("branch", ["-rvv"]).splitlines() if "HEAD" not in l]

    remote_branches = []

    for verbose_remote_branch in verbose_remote_branches:
        verbose_branch_info = verbose_remote_branch.split()

        name_idx = 1 if verbose_branch_info[0] == "*" else 0

        remote_branches.append(verbose_branch_info[name_idx])

    return remote_branches

# Determine whether branch name corresponds to a remote branch
def is_remote(branch):
    return branch in remotes()

if __name__ == "__main__":
    for branch, upstream in upstreams().iteritems():
        print branch, "_____________", upstream
