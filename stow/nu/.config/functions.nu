#!/usr/bin/env nu

# Activate a python virtual environment venv_activate <name-of-venv>
#
# If a folder containing `venv` is found as a child of the current dir,
# this script is searching for the `<folder>/bin/activate.nu` script.
# If multiple folder are found, the user is asked to chose which one
# he wants to use.
def venv_activate [venv] {
    use std log
    let venvs = (ls | where type == dir | where ($it.name | str contains $venv) | get name)
    if ( $venvs | is-empty ) {
        log warning "There are no virtualenv in this folder"
    } else {
        if ( ($venvs | length) == 1) {
            let venv_name = ($venvs | first)
            let venv_activation_file = ($env.pwd | path join $venv_name bin activate.nu)
            nu -e $"overlay use ($venv_activation_file) as ($venv_name)"
            log warning $"overlay done use ($venv_activation_file) as ($venv_name)"
        } else {
            print "The following venvs are available:"
            let choice = chose_one_in_list $venvs
            let venv_activation_file = ($env.pwd | path join $choice bin activate.nu)
            nu -e $"overlay use ($venv_activation_file) as ($choice)"
        }
    }
}

# deactivate the virtual environment venv_deactivate <name-of-venv>
def venv_deactivate [venv] {
   use std log
   let venvs = (ls | where type == dir | where ($it.name | str contains $venv) | get name)
   if ( $venvs | is-empty ) {
       log warning "There are no virtualenv in this folder"
   } else {
       if ( ($venvs | length) == 1) {
           let venv_name = ($venvs | first)
           nu -e $"overlay hide ($venv_name)"
       } else {
           print "The following venvs are available:"
           let choice = chose_one_in_list $venvs
           nu -e $"overlay hide ($choice)"
       }
   }
}

# System
do --env {
    let ssh_agent_file = (
        $nu.temp-path | path join $"ssh-agent-($env.USER? | default $env.USER).nuon"
    )

    if ($ssh_agent_file | path exists) {
        let ssh_agent_env = open ($ssh_agent_file)
        if ($"/proc/($ssh_agent_env.SSH_AGENT_PID)" | path exists) {
            load-env $ssh_agent_env
            return
        } else {
            rm $ssh_agent_file
        }
    }

    let ssh_agent_env = ^ssh-agent -c
        | lines
        | first 2
        | parse "setenv {name} {value};"
        | transpose --header-row
        | into record
    load-env $ssh_agent_env
    $ssh_agent_env | save --force $ssh_agent_file
}

# easier to read disk
#######################################################################
def dfh [] {
    df -h
    | detect columns
}

# Nix Home Manager
#######################################################################
def hmgd [] {
    let hmg = (home-manager generations
    | lines
    | first 2
    | reverse
    | each { |it| echo $it | split column " " | get 0 }
    | get column7)

    nix store diff-closures ($hmg | get 0) ($hmg | get 1)
}

# ##home-manager switch --flake .#mktxmac-kbiawat, when you already in that directory
def hms [] {
    home-manager switch --flake "/Users/mktxmac-kbiawat/Developer/.dotfiles/nix/home-manager#mktxmac-kbiawat"
    hmgd
}

def hmu [] {
    hmd
    nfu
    hms
}

# Git
#######################################################################
#git_branch_cleanup: delete git merged branches except master, main, local_mgmt_tgt_clusters, develop_ce, develop_eks
def git_branch_cleanup [] {
    let local_non_merged_branches = git branch --merged
                         | lines
                         | str trim
                         | where ( $it != "* master" and $it != "* main" and $it != "local_mgmt_tgt_clusters" and $it != "develop_ce" and $it != "develop_eks" )

    print $local_non_merged_branches

    let choice = [yes no]
            | input list $"(ansi green_bold)Are you sure: ?(ansi yellow_bold)"
    print $"(ansi reset)"

    if ( $choice == "yes" ) {
        print "Deleting branches"
        $local_non_merged_branches | each {|br| git branch -D ($br | str trim) } | str trim
    }
}


# Stow
#######################################################################
# stow (th stands for target=home)
def stowth [config] {
    stow -vSt ~ $config
}

def unstowth [config] {
    stow -vDt ~ $config
}


# Docker
#######################################################################
def docker-armageddon [] {
    docker stop "$(docker ps -aq)" # stop containers
    docker rm "$(docker ps -aq)" # rm containers
    docker network prune -f # rm networks
    docker rmi -f "$(docker images --filter dangling=true -qa)" # rm dangling images
    docker volume rm "$(docker volume ls --filter dangling=true -q)" # rm volumes
    docker rmi -f "$(docker images -qa)" # rm all images
}

# AWS
#######################################################################
# _aws_creds: helper function to format the aws creds
def _aws_creds [aws_creds] {
    {
      "AWS_ACCESS_KEY_ID": $aws_creds.AccessKeyId,
      "AWS_SECRET_ACCESS_KEY": $aws_creds.SecretAccessKey,
      "AWS_SESSION_TOKEN": $aws_creds.SessionToken,
      "AWS_SECURITY_TOKEN": $aws_creds.SessionToken
    }
}

#load_current_aws_creds: use `load_current_aws_creds | load-env` loads the current aws cred role in your current session
def load_current_aws_creds [] {
    let current_aws_creds = ls ~/.aws/cli/cache/*.json
                        | sort-by modified
                        | reverse
                        | ( get name | first )
                        | open $in
                        | get Credentials

    _aws_creds $current_aws_creds
}

# load_aws_profile: use `load_aws_profile | load-env` loads the current aws profile in your current session
def load_aws_profile [profile] {

    # remove the old creds
    rm -rf ~/.aws/cli/cache

    # assume the role using provided profile and verify by printing the current session
    aws --profile $profile sts get-caller-identity | from yaml | print $in

    #$"export AWS_ACCESS_KEY_ID=($current_aws_creds.AccessKeyId)\n" | save --append .env
    #$"export AWS_SECRET_ACCESS_KEY=($current_aws_creds.SecretAccessKey)\n" | save --append .env
    #$"export AWS_SESSION_TOKEN=($current_aws_creds.SessionToken)\n" | save --append .env
    #$"export AWS_SECURITY_TOKEN=($current_aws_creds.SessionToken)\n" | save --append .env

    # As above AWS creds are still within this function scope,
    # return the aws profile session to the current terminal to invoke this function with | load-env
    load_current_aws_creds
}

# load_aws_assume_role_arn: use `load_aws_assume_role_arn assume_role assume_session | load-env`
# using parent aws_profile, assume the target_aws_assume_role_arn
def load_aws_assume_role_arn [target_aws_assume_role_arn role_session_name] {
    let assumed_aws_creds = aws sts assume-role --role-arn $target_aws_assume_role_arn --role-session-name $role_session_name
                            | from json
                            | get Credentials

    #print $assumed_aws_creds

    # current session updated to that assumed aws role within this function scope
    _aws_creds $assumed_aws_creds | load-env
    # verifying, its actually the assume role now
    aws sts get-caller-identity | from yaml | print $in

    # return the assume role session to the current terminal to invoke this function with | load-env
    _aws_creds $assumed_aws_creds
}

# lets_aft: use lets_aft | load-env loads the AWSAFTAdmin assumed role in your current session
# uses CloudBreakglassRole to assume AWSAFTAdmin role
def lets_aft [] {
    # assume AFT_CloudBreakglassRole
    load_aws_profile <> | load-env

    let aws_account_id = <>
    let aws_account_role = "AWSAFTAdmin"

    let aft_admin_assume_role_arn = [arn:aws:iam:: $aws_account_id :role/ $aws_account_role] | str join
    load_aws_assume_role_arn $aft_admin_assume_role_arn aft
}