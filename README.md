# RexyGit

Toggle [lazygit](https://github.com/jesseduffield/lazygit) in a [Rex](https://www.superlogical.com/rex) pane with one key. Modelled on [rexdiff](https://github.com/rednafi/rexdiff).

Press <kbd>Cmd</kbd>+<kbd>L</kbd> to open lazygit in a floating pane, in the focused pane's working directory. Press it again to close it.

## Install

```sh
brew install lazygit
./install.sh
```

The installer copies two Lua files into Rex's config directory (`~/.config/rex` by default), adds `require("lazygit")` to `init.lua`, and reloads Rex. Run it again after you pull an update or move the lazygit binary.

To remove everything: `./uninstall.sh`.

## Settings

Edit `~/.config/rex/lazygit.lua`, then run `rex config reload`.

| Setting | Default | Values |
| --- | --- | --- |
| `key` | `"cmd+l"` | Any Rex key, or `false` for no key |
| `placement` | `"overlay"` | `overlay` (floating), `split`, `zoomed`, `tab` |
| `direction` | `"right"` | `right`, `down` (for `split` and `zoomed`) |
| `ratio` | `0.5` | The share of the split that lazygit gets, between 0 and 1 |

The action is also in the command palette as **Toggle lazygit**, and takes a one-off placement:

```sh
rex do lazygit_toggle placement=split
```

## How it works

- `lazygit.lua` holds your settings. The installer never overwrites it.
- `lazygit_toggle.lua` holds the action. The installer rewrites it on every run, with the path of lazygit at the top.
- The toggle looks in the focused tab for a pane labelled `lazygit`, or one whose process tree contains lazygit. If it finds any, it closes them. Otherwise it opens a new one.

## License

[MIT](LICENSE)
