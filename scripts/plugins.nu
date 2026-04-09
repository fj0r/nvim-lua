#!/usr/bin/env nu

# Neovim Built-in Package Manager - Plugin Management Script
# Simulates lazy.nvim behavior
# Reads plugin configuration from lua/manifest directory

export def main [cmd?: string, name?: string] {
    if $cmd == null {
        print "Usage:"
        print "  nu scripts/plugins.nu install - Install/update all enabled plugins"
        print "  nu scripts/plugins.nu update <plugin-name> - Update specified plugin"
        print "  nu scripts/plugins.nu sync - Sync all plugins to pack directory"
        print "  nu scripts/plugins.nu list - List all plugins"
        print "  nu scripts/plugins.nu clean - Clean disabled plugins"
        print "  nu scripts/plugins.nu init - Initialize directory structure"
        print "  nu scripts/plugins.nu status - Show plugin status"
        return
    }

    match $cmd {
        "install" => { install }
        "update" => {
            if $name == null {
                print "Error: update requires plugin name parameter"
                print "Usage: nu scripts/plugins.nu update <plugin-name>"
            } else {
                update $name
            }
        }
        "sync" => { sync }
        "list" => { list }
        "clean" => { clean }
        "init" => { init }
        "status" => { status }
        _ => {
            print $"Error: Unknown command '($cmd)'"
            print ""
            print "Usage:"
            print "  nu scripts/plugins.nu install - Install/update all enabled plugins"
            print "  nu scripts/plugins.nu update <plugin-name> - Update specified plugin"
            print "  nu scripts/plugins.nu sync - Sync all plugins to pack directory"
            print "  nu scripts/plugins.nu list - List all plugins"
            print "  nu scripts/plugins.nu clean - Clean disabled plugins"
            print "  nu scripts/plugins.nu init - Initialize directory structure"
            print "  nu scripts/plugins.nu status - Show plugin status"
        }
    }
}

# Get config root directory (current working directory)
def get_config_root [] {
    # Use current working directory as config root
    $env.PWD | path expand
}

# Get pack directory path
def get_pack_dir [] {
    let config_root = get_config_root
    ($config_root | path join "pack" "pafo")
}

# Get plugins repository directory
def get_plugins_dir [] {
    let config_root = get_config_root
    ($config_root | path join "plugins")
}

# Get lua/manifest directory
def get_manifest_dir [] {
    let config_root = get_config_root
    ($config_root | path join "lua" "manifest")
}

# Extract plugin information from lua file content (simplified version)
def extract_plugins [content: list<string>] {
    mut plugins = []
    mut current_name = ""
    mut current_tag = ""
    mut current_event = ""
    mut current_enabled = true

    for line in $content {
        let trimmed = ($line | str trim)

        # Skip comments and empty lines
        if ($trimmed | str starts-with "--") {
            continue
        }

        # Detect plugin line (contains 'owner/repo' format)
        if ($trimmed | str contains "/") and (($trimmed | str starts-with "'") or ($trimmed | str starts-with "{")) {
            # Extract plugin name - only match valid owner/repo format
            let name = ($trimmed | str replace -r ".*'([^/]+)/([^']+)'.*" "$1/$2" | str trim)
            # Validate name: must contain / and no spaces or special characters
            if ($name | str length) > 0 and ($name | str contains "/") and ($name !~ " ") {
                # Save previous plugin
                if $current_name != "" {
                    $plugins = ($plugins | append {
                        name: $current_name
                        tag: $current_tag
                        event: $current_event
                        enabled: $current_enabled
                    })
                }
                # Start new plugin
                $current_name = $name
                $current_tag = ""
                $current_event = ""
                $current_enabled = true
            }
        }

        # Detect tag
        if ($line | str contains "tag") and ($line | str contains "=") {
            mut tag_val = ($line | str replace -r ".*tag[ ]*=[ ]*'([^']+)'.*" "$1")
            if ($tag_val != $line) and ($tag_val | str length) > 0 {
                $current_tag = $tag_val
            } else {
                mut tag_val2 = ($line | str replace -r '.*tag[ ]*=[ ]*"([^"]+)".*' "$1")
                if ($tag_val2 != $line) and ($tag_val2 | str length) > 0 {
                    $current_tag = $tag_val2
                }
            }
        }

        # Detect event
        if ($line | str contains "event") and ($line | str contains "=") {
            mut event_val = ($line | str replace -r ".*event[ ]*=[ ]*'([^']+)'.*" "$1")
            if ($event_val != $line) and ($event_val | str length) > 0 {
                $current_event = $event_val
            } else {
                mut event_val2 = ($line | str replace -r '.*event[ ]*=[ ]*"([^"]+)".*' "$1")
                if ($event_val2 != $line) and ($event_val2 | str length) > 0 {
                    $current_event = $event_val2
                }
            }
        }

        # Detect enabled = false
        if ($line | str contains "enabled = false") or ($line | str contains "enabled=false") {
            $current_enabled = false
        }
    }

    # Add last plugin
    if $current_name != "" {
        $plugins = ($plugins | append {
            name: $current_name
            tag: $current_tag
            event: $current_event
            enabled: $current_enabled
        })
    }

    return $plugins
}

# Collect all plugins from manifest files
def collect_all_plugins [] {
    let manifest_dir = get_manifest_dir

    if not ($manifest_dir | path exists) {
        print $"Error: Manifest directory does not exist: ($manifest_dir)"
        return []
    }

    mut all_plugins = []

    # Get all lua files
    let lua_files = (ls $manifest_dir | where type == file | where name =~ ".lua" | get name)

    for file in $lua_files {
        let content = open $file | lines
        let file_plugins = (extract_plugins $content)
        $all_plugins = ($all_plugins ++ $file_plugins)
    }

    # Deduplicate by plugin name
    mut seen = []
    mut unique = []
    for p in $all_plugins {
        if ($seen | find $p.name | is-empty) {
            $seen = ($seen | append $p.name)
            $unique = ($unique | append $p)
        }
    }

    return $unique
}

# Clone or update plugin repository
def update_plugin_repo [plugin: record] {
    let plugins_dir = get_plugins_dir
    let plugin_basename = ($plugin.name | path basename)
    let plugin_path = ($plugins_dir | path join $plugin_basename)

    if (not ($plugin_path | path exists)) {
        print $"  [Install] ($plugin.name)"
        let repo_url = $"https://github.com/($plugin.name).git"

        mkdir $plugins_dir
        cd $plugins_dir

        if ($plugin.tag | is-not-empty) {
            git clone --depth 1 --branch $plugin.tag $repo_url $plugin_basename
        } else {
            git clone --depth 1 $repo_url $plugin_basename
        }

        cd -
    } else {
        print $"  [Update] ($plugin.name)"
        cd $plugin_path
        git fetch --quiet
        if ($plugin.tag | is-not-empty) {
            git checkout $plugin.tag --quiet
        } else {
            git pull --ff-only --quiet
        }
        cd -
    }
}

# Sync plugin to pack directory
def sync_plugin_to_pack [plugin: record] {
    let plugins_dir = get_plugins_dir
    let pack_dir = get_pack_dir
    let plugin_name = ($plugin.name | path basename)
    let plugin_path = ($plugins_dir | path join $plugin_name)

    if not ($plugin_path | path exists) {
        print $"  [Skip] ($plugin.name) - Not installed"
        return
    }

    # Determine start or opt directory
    let load_type = if ($plugin.event | is-not-empty) { "opt" } else { "start" }
    let target_dir = ($pack_dir | path join $load_type)

    mkdir $target_dir

    let target_path = ($target_dir | path join $plugin_name)

    if ($target_path | path exists) {
        if ($target_path | path type) == "symlink" {
            rm $target_path
        } else {
            rm -rf $target_path
        }
    }

    ln -s $plugin_path $target_path
    print $"  [Sync] ($plugin.name) -> ($load_type)"
}

# Install all enabled plugins
export def install [] {
    print "=========================================="
    print "Neovim Plugin Installation/Update"
    print "=========================================="
    print ""

    print "Collecting plugin list..."
    let plugins = collect_all_plugins

    if ($plugins | length) == 0 {
        print "No plugins found"
        return
    }

    print $"Found ($plugins | length) unique definitions"
    print ""

    let enabled_count = ($plugins | where enabled == true | length)
    let disabled_count = ($plugins | length) - $enabled_count

    print $"Enabled plugins: ($enabled_count)"
    print $"Disabled plugins: ($disabled_count)"
    print ""

    print "Processing plugin repositories..."
    for plugin in ($plugins | where enabled == true) {
        update_plugin_repo $plugin
    }

    print ""
    print "Syncing plugins to pack directory..."

    let pack_dir = get_pack_dir
    mkdir ($pack_dir | path join "start")
    mkdir ($pack_dir | path join "opt")

    for plugin in ($plugins | where enabled == true) {
        sync_plugin_to_pack $plugin
    }

    print ""
    print "=========================================="
    print "Plugin installation complete!"
    print "=========================================="
    print ""
    print "Restart Neovim to load new plugins"
}

# Update specified plugin
export def update [plugin_name: string] {
    let plugins_dir = get_plugins_dir
    let plugin_path = ($plugins_dir | path join $plugin_name)

    if not ($plugin_path | path exists) {
        # Try to find matching plugin
        let plugins = collect_all_plugins
        let matching = ($plugins | where ($it.name | str contains $plugin_name))

        if ($matching | length) == 0 {
            print $"Error: Plugin not found: ($plugin_name)"
            return
        } else if ($matching | length) > 1 {
            print $"Found multiple matching plugins:"
            for m in $matching {
                print $"  - ($m.name)"
            }
            return
        } else {
            let plugin_path = ($plugins_dir | path join $matching.0.name)
            update_plugin_repo $matching.0
            sync_plugin_to_pack $matching.0
            print $"Updated plugin: ($plugin_path | path basename)"
            return
        }
    }

    let actual_name = ($plugin_path | path basename)
    print $"Updating plugin: ($actual_name)"
    cd $plugin_path
    git fetch --all --quiet
    git pull --ff-only --quiet
    cd -

    # Sync to pack directory
    let plugins = collect_all_plugins
    let plugin_record = ($plugins | where ($it.name | path basename) == $actual_name | first)
    if $plugin_record != null {
        sync_plugin_to_pack $plugin_record
    }

    print $"Updated plugin: ($actual_name)"
}

# Sync all installed plugins to pack directory
export def sync [] {
    print "Syncing plugins to pack directory..."
    print ""

    let plugins = collect_all_plugins

    let pack_dir = get_pack_dir
    mkdir ($pack_dir | path join "start")
    mkdir ($pack_dir | path join "opt")

    for plugin in ($plugins | where enabled == true) {
        sync_plugin_to_pack $plugin
    }

    print ""
    print "Sync complete!"
}

# List all plugins
export def list [] {
    let plugins = collect_all_plugins

    print "=========================================="
    print $"Plugin List - Total: ($plugins | length)"
    print "=========================================="
    print ""

    let enabled = ($plugins | where enabled == true | sort-by name)
    let disabled = ($plugins | where enabled == false | sort-by name)

    if ($enabled | length) > 0 {
        print $"[Enabled] ($enabled | length) plugins"
        print "------------------------------------------"
        for plugin in $enabled {
            mut info = ""
            if ($plugin.event | is-not-empty) {
                $info = ([$info, " (event: ", $plugin.event, ")"] | str join "")
            }
            if ($plugin.tag | is-not-empty) {
                $info = ([$info, " (tag: ", $plugin.tag, ")"] | str join "")
            }
            print $"  ✓ ($plugin.name)($info)"
        }
        print ""
    }

    if ($disabled | length) > 0 {
        print $"[Disabled] ($disabled | length) plugins"
        print "------------------------------------------"
        for plugin in $disabled {
            print $"  ✗ ($plugin.name)"
        }
        print ""
    }
}

# Clean disabled plugins
export def clean [] {
    print "Cleaning disabled and unused plugins..."
    print ""

    let plugins = collect_all_plugins
    let plugins_dir = get_plugins_dir
    let pack_dir = get_pack_dir

    let enabled_basenames = ($plugins
        | where enabled == true
        | get name
        | each { |n| $n | path basename })

    # Clean plugins directory
    if ($plugins_dir | path exists) {
        print "Cleaning plugins directory..."
        for dir in (ls -D $plugins_dir | get name) {
            let plugin_basename = ($dir | path basename)
            if ($enabled_basenames | find $plugin_basename | is-empty) {
                print $"  [Remove] ($plugin_basename)"
                rm -rf $dir
            }
        }
    }

    # Clean pack directory
    for load_type in ["start" "opt"] {
        let load_dir = ($pack_dir | path join $load_type)
        if ($load_dir | path exists) {
            print $"Cleaning pack/.../($load_type) directory..."
            for link in (ls -D $load_dir | get name) {
                let plugin_basename = ($link | path basename)
                if ($enabled_basenames | find $plugin_basename | is-empty) {
                    print $"  [Remove link] ($plugin_basename)"
                    rm -rf $link
                }
            }
        }
    }

    print ""
    print "Clean complete!"
}

# Initialize directory structure and install plugins
export def init [] {
    let config_root = get_config_root
    let plugins_dir = get_plugins_dir
    let pack_dir = get_pack_dir

    print "=========================================="
    print "Neovim Built-in Package Manager Initialization"
    print "=========================================="
    print ""
    print $"Config root: ($config_root)"
    print ""

    # Create directory structure
    print "Creating directory structure..."
    mkdir $plugins_dir
    mkdir ($pack_dir | path join "start")
    mkdir ($pack_dir | path join "opt")
    print $"  ✓ ($plugins_dir)"
    print $"  ✓ ($pack_dir | path join 'start')"
    print $"  ✓ ($pack_dir | path join 'opt')"
    print ""

    # Run plugin installation
    print "Running plugin installation..."
    print ""
    install

    print ""
    print "=========================================="
    print "Initialization complete!"
    print "=========================================="
    print ""
    print "Next steps:"
    print "1. Run 'nvim' to start Neovim"
    print "2. Check if plugins load correctly"
    print "3. If issues occur, check :messages or use nvim -V for debugging"
    print ""
}

# Show plugin status
export def status [] {
    print "=========================================="
    print "Neovim Plugin Status"
    print "=========================================="
    print ""

    let config_root = get_config_root
    let plugins_dir = get_plugins_dir
    let pack_dir = get_pack_dir

    # Check directory structure
    print "[Directory Structure]"
    let config_ok = if ($config_root | path exists) { "✓" } else { "✗" }
    let plugins_ok = if ($plugins_dir | path exists) { "✓" } else { "✗" }
    let start_ok = if (($pack_dir | path join "start") | path exists) { "✓" } else { "✗" }
    let opt_ok = if (($pack_dir | path join "opt") | path exists) { "✓" } else { "✗" }

    print $"  Config directory: ($config_root) - ($config_ok)"
    print $"  Plugins repository: ($plugins_dir) - ($plugins_ok)"
    print $"  Pack/start: ($pack_dir | path join 'start') - ($start_ok)"
    print $"  Pack/opt:   ($pack_dir | path join 'opt') - ($opt_ok)"
    print ""

    # Plugin statistics
    let plugins = collect_all_plugins
    let enabled = ($plugins | where enabled == true)

    let installed = if ($plugins_dir | path exists) {
        (ls -D $plugins_dir | length)
    } else {
        0
    }

    let in_start = if (($pack_dir | path join "start") | path exists) {
        (ls -D ($pack_dir | path join "start") | length)
    } else {
        0
    }

    let in_opt = if (($pack_dir | path join "opt") | path exists) {
        (ls -D ($pack_dir | path join "opt") | length)
    } else {
        0
    }

    print "[Plugin Statistics]"
    print $"  Configured: ($plugins | length) (Enabled: ($enabled | length), Disabled: (($plugins | length) - ($enabled | length)))"
    print $"  Installed: ($installed)"
    print $"  Pack/start: ($in_start)"
    print $"  Pack/opt:   ($in_opt)"
    print ""

    # Check Neovim
    if (which nvim | is-empty) {
        print "[Neovim] Not found"
    } else {
        let version = (^nvim --version | first)
        print $"[Neovim] ($version)"
    }
}
