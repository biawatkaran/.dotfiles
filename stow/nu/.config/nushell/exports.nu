def load_exports [] {
    {
        ####### Misc #######
        #"CARAPACE_BRIDGES": 'zsh,fish,bash,inshellisense'

        ####### HISTFILE #######
        "HISTSIZE": "100000"
        "SAVEHIST": "100000"
        "LANG": "C.UTF-8"

        ####### FZF #######
        #"FZF_DEFAULT_COMMAND": "fd --type f --color=never --hidden"
        #"FZF_DEFAULT_OPTS": "--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b"
        #"FZF_CTRL_T_COMMAND": $env.FZF_DEFAULT_COMMAND
        #"FZF_CTRL_T_OPTS": "--preview 'bat --color=always --line-range :50 {}'"
        #"FZF_ALT_C_COMMAND": 'fd --type d . --color=never --hidden'
        #"FZF_ALT_C_OPTS": "--preview 'tree -C {} | head -50'"

        ####### Docker/Colima #######
        "TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE": "/var/run/docker.sock"
        "DOCKER_HOST": (["unix://" $env.HOME "/.colima/default/docker.sock"] | str join)

        ####### Earthly #######
        "EARTHLY_BUILDKIT_IMAGE": "mktxv-docker-prod-virtual.artifacts.tools.marketaxess.com/earthly/buildkitd:v0.8.15"
        "EARTHLY_SECRET_FILES": (["netrc=" $env.HOME "/.netrc"] | str join)
        "EARTHLY_DISABLE_REMOTE_REGISTRY_PROXY": "true"
        "EARTHLY_SECRETS": "ARTIFACTORY_USR,ARTIFACTORY_PSW"

        ####### GIT #######
        "GIT_PS1_SHOWDIRTYSTATE": "0"
        "GIT_PS1_SHOWSTASHSTATE": "0"

        #####################################################################
        #                             Certs                                 #
        #    commented for local machine, check at corporate level          #
        #####################################################################
        #"CERT_FILE": "/etc/nix/ca_cert.pem"

        #AWS
        #"AWS_CA_BUNDLE": "/etc/nix/ca_cert.pem"

        #OpenSSL
        #"OPENSSL_CONF": "/etc/ssl/openssl.cnf"
        #"SSL_CERT_FILE": $env.CERT_FILE

        #Nix
        #"NIX_SSL_CERT_FILE": $env.CERT_FILE

        #Python
        #"REQUESTS_CA_BUNDLE": $env.CERT_FILE


        ####### Python #######
        "PIP_INDEX_URL": "https://artifacts.tools.marketaxess.com/artifactory/api/pypi/mktxv-pypi-prod-virtual/simple"
        #"PIP_DISABLE_PIP_VERSION_CHECK": "1"
        "PIP_ROOT_USER_ACTION": "ignore"

        ####### Go #######
        "GOPATH": "/Users/mktxmac-kbiawat/Developer/workspaces/golang_ws"

        ####### Java #######
        "JAVA_TOOL_OPTIONS": "-Dconfig.override_with_env_vars=true -Djava.net.preferIPv4Stack=true -Duser.timezone=UTC"

        ####### Terraform #######
        "TF_LOG": "DEBUG"
        "TF_LOG_PATH": ([$env.HOME /terraform.log] | str join)
    }
}