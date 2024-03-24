New-Item -ItemType SymbolicLink -Target "$env:USERPROFILE\.dotfiles\nvim" -Path "$env:USERPROFILE\AppData\Local\nvim" -Force
New-Item -ItemType SymbolicLink -Target "$env:USERPROFILE\.dotfiles\wezterm" -Path "$env:USERPROFILE\.config\wezterm" -Force
New-Item -ItemType SymbolicLink -Target "$env:USERPROFILE\.dotfiles\.gitconfig" -Path "$env:USERPROFILE\.gitconfig" -Force
