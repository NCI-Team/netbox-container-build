#!/bin/sh

# # Auto-Get the latest commit sha via command line.
# get_latest_release() {
#     tag=$(curl --silent "https://api.github.com/repos/${1}/releases/tags/${2}" | # Get latest release from GitHub API
#         grep '"tag_name":'                                              | # Get tag line
#     sed -E 's/.*"([^"]+)".*/\1/'                                    ) # Pluck JSON value
    
#     tag_data=$(curl --silent "https://api.github.com/repos/${1}/git/ref/tags/${tag}")
    
#     sha=$(echo "${tag_data}"           | # Get latest release from GitHub API
#         grep '"sha":'                | # Get tag line
#     sed -E 's/.*"([^"]+)".*/\1/' ) # Pluck JSON value
    
#     sha_type=$(echo "${tag_data}"           | # Get latest release from GitHub API
#         grep '"type":'                    | # Get tag line
#     sed -E 's/.*"([^"]+)".*/\1/'      ) # Pluck JSON value
    
#     if [ "${sha_type}" != "commit" ]; then
#         combo_sha=$(curl -s "https://api.github.com/repos/${1}/git/tags/${sha}" | # Get latest release from GitHub API
#             grep '"sha":'                                                     | # Get tag line
#         sed -E 's/.*"([^"]+)".*/\1/'                                      ) # Pluck JSON value
        
#         # Remove the tag sha, leaving only the commit sha;
#         # this won't work if there are ever more than 2 sha,
#         # and use xargs to remove whitespace/newline.
#         sha=$(echo "${combo_sha}" | sed -E "s/${sha}//" | xargs)
#     fi
    
#     printf "${sha}"
# }

# commit_sha=$(get_latest_release "${owner}/${repo}" "${version}")
# version='1.89.0'
# owner='microsoft'
# repo='vscode'


##########################################################################################
# GIL COMMENT: the vscode commit can't be dynamiclly pulled, it has to be static because
# it has to match the vscode version we have in our environment.
##########################################################################################


set -e

ARCH="x64"
archive="vscode-server-linux-${ARCH}.tar.gz"
commit_sha="912bb683695358a54ae0c670461738984cbb5b95"

if [ -n "${commit_sha}" ]; then
    echo "will attempt to download VS Code Server version = '${commit_sha}'"
    
    # Download VS Code Server tarball to tmp directory.
    curl -L "https://update.code.visualstudio.com/commit:${commit_sha}/server-linux-${ARCH}/stable" -o "/tmp/${archive}"
    
    # Make the parent directory where the server should live.
    # NOTE: Ensure VS Code will have read/write access; namely the user running VScode or container user.
    mkdir -vp ~/.vscode-server/bin/"${commit_sha}"
    
    # Extract the tarball to the right location.
    tar --no-same-owner -xzv --strip-components=1 -C ~/.vscode-server/bin/"${commit_sha}" -f "/tmp/${archive}"
    # Add symlink
    cd ~/.vscode-server/bin && ln -s "${commit_sha}" default_version
else
    echo "could not pre install vscode server"
fi

export PATH="$PATH:/root/.vscode-server/bin/${commit_sha}/bin"

for FILE in /opt/vscode-server/*.vsix; do code-server --install-extension $FILE; done
