
# === {{CMD}}  data.json  template.handlebars
template-render () {

  local DATA="$(realpath -m "$1")"; shift
  local TEMPLATE="$(realpath -m "$1")"; shift
  local HANDLE_BARS="$THIS_DIR/node_modules/handlebars"

  cd $THIS_DIR

  if [[ ! -d "$HANDLE_BARS" ]]; then
    bash_setup BOLD "=== Installing: {{handlebars}}" 1>&2
    npm install handlebars
  fi

  node bin/lib/template-render.js "$DATA" "$TEMPLATE"

} # === end function

specs () {
  local TMP="/tmp/bash_setup/template-render"
  reset-fs () {
    rm -rf "$TMP"
    mkdir -p "$TMP"
    cd $TMP
  }

  # =================================================================================================
  reset-fs
  bash_setup BOLD "=== Renders: {{data.json  template.txt}}"
  echo '{"name":"ted","corp":"General Creative"}' > data.json
  echo "RESULT: {{name}}  {{corp}}"               > template.txt
  should-match "RESULT: ted  General Creative"  "bash_setup template-render  data.json  template.txt"
  # =================================================================================================

  # =================================================================================================
  reset-fs
  bash_setup BOLD "=== Renders: {{nested vars}}"
  echo '{"name":"ted","corp":"General Creative","full":"{{name}} {{corp}}"}' > data.json
  echo "RESULT: {{full}}" > template.txt
  should-match "RESULT: ted General Creative"  "bash_setup template-render  data.json  template.txt"
  # =================================================================================================


}
