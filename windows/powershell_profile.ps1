using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'rustup' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'rustup'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-')) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'rustup' {
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose output')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose output')
            [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Disable progress output')
            [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Disable progress output')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('dump-testament', 'dump-testament', [CompletionResultType]::ParameterValue, 'Dump information about the build')
            [CompletionResult]::new('show', 'show', [CompletionResultType]::ParameterValue, 'Show the active and installed toolchains or profiles')
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Update Rust toolchains')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall Rust toolchains')
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Update Rust toolchains and rustup')
            [CompletionResult]::new('check', 'check', [CompletionResultType]::ParameterValue, 'Check for updates to Rust toolchains and rustup')
            [CompletionResult]::new('default', 'default', [CompletionResultType]::ParameterValue, 'Set the default toolchain')
            [CompletionResult]::new('toolchain', 'toolchain', [CompletionResultType]::ParameterValue, 'Modify or query the installed toolchains')
            [CompletionResult]::new('target', 'target', [CompletionResultType]::ParameterValue, 'Modify a toolchain''s supported targets')
            [CompletionResult]::new('component', 'component', [CompletionResultType]::ParameterValue, 'Modify a toolchain''s installed components')
            [CompletionResult]::new('override', 'override', [CompletionResultType]::ParameterValue, 'Modify directory toolchain overrides')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run a command with an environment configured for a given toolchain')
            [CompletionResult]::new('which', 'which', [CompletionResultType]::ParameterValue, 'Display which binary will be run for a given command')
            [CompletionResult]::new('doc', 'doc', [CompletionResultType]::ParameterValue, 'Open the documentation for the current toolchain')
            [CompletionResult]::new('self', 'self', [CompletionResultType]::ParameterValue, 'Modify the rustup installation')
            [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Alter rustup settings')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate tab-completion scripts for your shell')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Prints this message or the help of the given subcommand(s)')
            break
        }
        'rustup;dump-testament' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;show' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('active-toolchain', 'active-toolchain', [CompletionResultType]::ParameterValue, 'Show the active toolchain')
            [CompletionResult]::new('home', 'home', [CompletionResultType]::ParameterValue, 'Display the computed value of RUSTUP_HOME')
            [CompletionResult]::new('profile', 'profile', [CompletionResultType]::ParameterValue, 'Show the current profile')
            [CompletionResult]::new('keys', 'keys', [CompletionResultType]::ParameterValue, 'Display the known PGP keys')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Prints this message or the help of the given subcommand(s)')
            break
        }
        'rustup;show;active-toolchain' {
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose output with rustc information')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose output with rustc information')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;show;home' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;show;profile' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;show;keys' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;show;help' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;install' {
            [CompletionResult]::new('--profile', 'profile', [CompletionResultType]::ParameterName, 'profile')
            [CompletionResult]::new('--no-self-update', 'no-self-update', [CompletionResultType]::ParameterName, 'Don''t perform self-update when running the `rustup install` command')
            [CompletionResult]::new('--force', 'force', [CompletionResultType]::ParameterName, 'Force an update, even if some components are missing')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;uninstall' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;update' {
            [CompletionResult]::new('--no-self-update', 'no-self-update', [CompletionResultType]::ParameterName, 'Don''t perform self update when running the `rustup update` command')
            [CompletionResult]::new('--force', 'force', [CompletionResultType]::ParameterName, 'Force an update, even if some components are missing')
            [CompletionResult]::new('--force-non-host', 'force-non-host', [CompletionResultType]::ParameterName, 'Install toolchains that require an emulator. See https://github.com/rust-lang/rustup/wiki/Non-host-toolchains')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;check' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;default' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;toolchain' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed toolchains')
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Install or update a given toolchain')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall a toolchain')
            [CompletionResult]::new('link', 'link', [CompletionResultType]::ParameterValue, 'Create a custom toolchain by symlinking to a directory')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Prints this message or the help of the given subcommand(s)')
            break
        }
        'rustup;toolchain;list' {
            [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Enable verbose output with toolchain information')
            [CompletionResult]::new('--verbose', 'verbose', [CompletionResultType]::ParameterName, 'Enable verbose output with toolchain information')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;toolchain;install' {
            [CompletionResult]::new('--profile', 'profile', [CompletionResultType]::ParameterName, 'profile')
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Add specific components on installation')
            [CompletionResult]::new('--component', 'component', [CompletionResultType]::ParameterName, 'Add specific components on installation')
            [CompletionResult]::new('-t', 't', [CompletionResultType]::ParameterName, 'Add specific targets on installation')
            [CompletionResult]::new('--target', 'target', [CompletionResultType]::ParameterName, 'Add specific targets on installation')
            [CompletionResult]::new('--no-self-update', 'no-self-update', [CompletionResultType]::ParameterName, 'Don''t perform self update when running the`rustup toolchain install` command')
            [CompletionResult]::new('--force', 'force', [CompletionResultType]::ParameterName, 'Force an update, even if some components are missing')
            [CompletionResult]::new('--allow-downgrade', 'allow-downgrade', [CompletionResultType]::ParameterName, 'Allow rustup to downgrade the toolchain to satisfy your component choice')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;toolchain;uninstall' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;toolchain;link' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;toolchain;help' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;target' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed and available targets')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a target to a Rust toolchain')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove a target from a Rust toolchain')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Prints this message or the help of the given subcommand(s)')
            break
        }
        'rustup;target;list' {
            [CompletionResult]::new('--toolchain', 'toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('--installed', 'installed', [CompletionResultType]::ParameterName, 'List only installed targets')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;target;add' {
            [CompletionResult]::new('--toolchain', 'toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;target;remove' {
            [CompletionResult]::new('--toolchain', 'toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;target;help' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;component' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed and available components')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a component to a Rust toolchain')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove a component from a Rust toolchain')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Prints this message or the help of the given subcommand(s)')
            break
        }
        'rustup;component;list' {
            [CompletionResult]::new('--toolchain', 'toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('--installed', 'installed', [CompletionResultType]::ParameterName, 'List only installed components')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;component;add' {
            [CompletionResult]::new('--toolchain', 'toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('--target', 'target', [CompletionResultType]::ParameterName, 'target')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;component;remove' {
            [CompletionResult]::new('--toolchain', 'toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('--target', 'target', [CompletionResultType]::ParameterName, 'target')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;component;help' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;override' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List directory toolchain overrides')
            [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the override toolchain for a directory')
            [CompletionResult]::new('unset', 'unset', [CompletionResultType]::ParameterValue, 'Remove the override toolchain for a directory')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Prints this message or the help of the given subcommand(s)')
            break
        }
        'rustup;override;list' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;override;set' {
            [CompletionResult]::new('--path', 'path', [CompletionResultType]::ParameterName, 'Path to the directory')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;override;unset' {
            [CompletionResult]::new('--path', 'path', [CompletionResultType]::ParameterName, 'Path to the directory')
            [CompletionResult]::new('--nonexistent', 'nonexistent', [CompletionResultType]::ParameterName, 'Remove override toolchain for all nonexistent directories')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;override;help' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;run' {
            [CompletionResult]::new('--install', 'install', [CompletionResultType]::ParameterName, 'Install the requested toolchain if needed')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;which' {
            [CompletionResult]::new('--toolchain', 'toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;doc' {
            [CompletionResult]::new('--toolchain', 'toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('--path', 'path', [CompletionResultType]::ParameterName, 'Only print the path to the documentation')
            [CompletionResult]::new('--alloc', 'alloc', [CompletionResultType]::ParameterName, 'The Rust core allocation and collections library')
            [CompletionResult]::new('--book', 'book', [CompletionResultType]::ParameterName, 'The Rust Programming Language book')
            [CompletionResult]::new('--cargo', 'cargo', [CompletionResultType]::ParameterName, 'The Cargo Book')
            [CompletionResult]::new('--core', 'core', [CompletionResultType]::ParameterName, 'The Rust Core Library')
            [CompletionResult]::new('--edition-guide', 'edition-guide', [CompletionResultType]::ParameterName, 'The Rust Edition Guide')
            [CompletionResult]::new('--nomicon', 'nomicon', [CompletionResultType]::ParameterName, 'The Dark Arts of Advanced and Unsafe Rust Programming')
            [CompletionResult]::new('--proc_macro', 'proc_macro', [CompletionResultType]::ParameterName, 'A support library for macro authors when defining new macros')
            [CompletionResult]::new('--reference', 'reference', [CompletionResultType]::ParameterName, 'The Rust Reference')
            [CompletionResult]::new('--rust-by-example', 'rust-by-example', [CompletionResultType]::ParameterName, 'A collection of runnable examples that illustrate various Rust concepts and standard libraries')
            [CompletionResult]::new('--rustc', 'rustc', [CompletionResultType]::ParameterName, 'The compiler for the Rust programming language')
            [CompletionResult]::new('--rustdoc', 'rustdoc', [CompletionResultType]::ParameterName, 'Generate documentation for Rust projects')
            [CompletionResult]::new('--std', 'std', [CompletionResultType]::ParameterName, 'Standard library API documentation')
            [CompletionResult]::new('--test', 'test', [CompletionResultType]::ParameterName, 'Support code for rustc''s built in unit-test and micro-benchmarking framework')
            [CompletionResult]::new('--unstable-book', 'unstable-book', [CompletionResultType]::ParameterName, 'The Unstable Book')
            [CompletionResult]::new('--embedded-book', 'embedded-book', [CompletionResultType]::ParameterName, 'The Embedded Rust Book')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;self' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Download and install updates to rustup')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall rustup.')
            [CompletionResult]::new('upgrade-data', 'upgrade-data', [CompletionResultType]::ParameterValue, 'Upgrade the internal data format.')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Prints this message or the help of the given subcommand(s)')
            break
        }
        'rustup;self;update' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;self;uninstall' {
            [CompletionResult]::new('-y', 'y', [CompletionResultType]::ParameterName, 'y')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;self;upgrade-data' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;self;help' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;set' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('default-host', 'default-host', [CompletionResultType]::ParameterValue, 'The triple used to identify toolchains when not specified')
            [CompletionResult]::new('profile', 'profile', [CompletionResultType]::ParameterValue, 'The default components installed')
            [CompletionResult]::new('auto-self-update', 'auto-self-update', [CompletionResultType]::ParameterValue, 'The rustup auto self update mode')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Prints this message or the help of the given subcommand(s)')
            break
        }
        'rustup;set;default-host' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;set;profile' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;set;auto-self-update' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;set;help' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;completions' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
        'rustup;help' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}

# Set oh-my-posh theme to zash
Set-PoshPrompt -Theme zash
# Invoke-Expression (&starship init powershell)

# Create a new empty file in the current working directory
function touch ([string] $fileName) {
    if (!(Test-Path $fileName)) {
        Write-Host "Creating $fileName"
        New-Item -Path . -Name $fileName -ItemType File
    } else {
        Write-Host "File '$fileName' already exists"
    }
}

# Create a directory in the current working directory
function mkdir ([string] $dirName) {
    if (!(Test-Path $dirName)) {
        Write-Host "Creating $dirName"
        New-Item -Path . -Name $dirName -ItemType Directory
    } else {
        Write-Host "Directory '$dirName' already exists"
    }
}

# Create and move into the directory
function mkcd ([string] $dirName) {
    if (!(Test-Path $dirName)) {
        mkdir($dirName)
        Set-Location $dirName
    } else {
        Write-Host "Directory '$dirName' already exists! Moving into the directory."
        Set-Location $dirName
    }
}

# Clone the repository at the specified URL with specified branch
function clone ([string] $repo, [string] $branch) {
    if ($repo -ne "") {
        if ($branch -ne "") {
            git clone git@github.com:$repo -b $branch
        } else {
            git clone git@github.com:$repo
        }
    } else {
        Write-Host "You must specify a repository URL!"
    }
}

# Create a signed commit with given message
function commit ([string] $commitMessage) {
    if ($commitMessage -ne "") {
        git commit --all -S -m $commitMessage
    } else {
        Write-Host "Aborting! No commit message provided."
    }
}

# Show oneline log of commits of given size
function lg ([int] $logSize) {
    if ($logSize -le 0) {
        Write-Host "Using default log size of 10"
        git log --oneline -n 10
    } else {
        git log --oneline -n $logSize
    }
}

# Push changes to github repository
function push ([string] $arg) {
    if ($arg -eq "f") {
        Write-Host "Force pushing.."
        git push --force
    } else {
        Write-Host "Pushing.."
        git push
    }
}

# Rebase given number of commits on current branch
function rebase ([int] $num) {
    if ($num -eq 0) {
        Write-Host "Bruh! How many number of commits?"
    } else {
        git rebase -i HEAD~$num
    }
}

# Reload powershell profile
function reload {
    . $PROFILE
    & $PROFILE
}

# Flutter Stuff
function runner { flutter packages pub run build_runner build --delete-conflicting-outputs }

function spbuild { flutter build apk -t .\lib\main_debug.dart --release --split-per-abi }

function build { flutter build apk -t .\lib\main_debug.dart --release }

function run { flutter run -t .\lib\main_debug.dart --debug }

# Open scrcpy with the given options
function device { scrcpy --always-on-top -w -b2M -m800 }

# Modify the most recent commit
function amend { git commit --amend -S }

# Stage all file changes to git
function add { git add --all }

# Pull all changes from the remote repository
function pull { git pull }

# Show the status of files in the current working directory
function st { git status }
