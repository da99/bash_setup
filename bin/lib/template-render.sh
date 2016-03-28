
# === {{CMD}}  data.json  template.handlebars
# === NAME=VAL OTHER=value  {{CMD}}  template.handlebars
template-render () {

  local DATA="$(realpath -m "$1")"; shift
  local TEMPLATE

  if [[ -z "$@" ]]; then
    TEMPLATE="$DATA"
    DATA="ENV"
  else
    local TEMPLATE="$(realpath -m "$1")"; shift
  fi

  local HANDLE_BARS="$THIS_DIR/node_modules/handlebars"

  cd $THIS_DIR

  if [[ ! -d "$HANDLE_BARS" ]]; then
    bash_setup BOLD "=== Installing: {{handlebars}}" 1>&2
    npm install handlebars
  fi

  node bin/lib/template-render.js "$DATA" "$TEMPLATE"

} # === end function ================================================================================

specs () {
  local TMP="/tmp/bash_setup/template-render"
  reset-fs () {
    rm -rf "$TMP"
    mkdir -p "$TMP"
    cd $TMP
  }

  # =================================================================================================
  reset-fs
  bash_setup BOLD "=== Renders: {{data.json  template.txt}}: " "-n"
  echo '{"name":"ted","corp":"General Creative"}' > data.json
  echo "RESULT: {{name}}  {{corp}}"               > template.txt
  should-match "RESULT: ted  General Creative"  "bash_setup template-render  data.json  template.txt"
  # =================================================================================================

  # =================================================================================================
  reset-fs
  bash_setup BOLD "=== Renders: {{nested vars}}: " "-n"
  echo '{"name":"ted","corp":"General Creative","full":"{{name}} {{corp}}"}' > data.json
  echo "RESULT: {{full}}" > template.txt
  should-match "RESULT: ted General Creative"  "bash_setup template-render  data.json  template.txt"
  # =================================================================================================

  # =================================================================================================
  reset-fs
  bash_setup BOLD "=== Renders: {{ENV vars}}: " "-n"
  echo "RESULT: {{NAME}} {{CORP}}" > template.txt
  should-match "RESULT: ted General Creative"  "NAME=\"ted\" CORP=\"General Creative\" bash_setup template-render template.txt"
  # =================================================================================================
} # === specs
