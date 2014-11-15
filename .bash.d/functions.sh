# Bash functions
#

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
# Credits: https://github.com/mathiasbynens/dotfiles/

function getcertnames() {
if [ -z "${1}" ]; then
    echo "ERROR: No domain specified."
    return 1
fi

local domain="${1}"
echo "Testing ${domain}…"
echo # newline

local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
    | openssl s_client -connect "${domain}:443" 2>&1);

if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText=$(echo "${tmp}" \
        | openssl x509 -text -certopt "no_header, no_serial, no_version, \
        no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux");
    echo "Common Name:"
    echo # newline
    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//";
    echo # newline
    echo "Subject Alternative Name(s):"
    echo # newline
    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
        | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
    return 0
else
    echo "ERROR: Certificate not found.";
    return 1
fi

}

# Create a new directory and enter it
# Credits: https://github.com/mathiasbynens/dotfiles/
function mkd() {
mkdir -p "$@" && cd "$@"
}

# Search in the history for the commands that are used the most
# Credits: https://coderwall.com/p/o5qijw
function topcmd() {
history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# Validate the syntax of an ERB template
# Source: Turnbull & McCune (2011). Pro Puppet. Apress. (p. 51)
function validate_erb() {
erb -x -T '-' "${1}" | ruby -c
}

# Print a list of manually installed packages
# credits: http://forums.fedoraforum.org/showpost.php?p=1606568&postcount=12
listinstalled() {
  yumdb search command_line "*install*" \
    | grep command_line \
    | sed 's/.*install//' \
    | tr ' ' '\n' \
    | sort --unique
}
