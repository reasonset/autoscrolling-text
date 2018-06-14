# autoscrolling-text

An auto scrolling text reader.

## Description

This script generates HTML from text, and show auto-scrollable page with JavaScript.

Use Surf for viewing by default.

## Dependency

* Pandoc
* Zsh
* Surf (for Surf)
* Python (for UnSurf)
* PyQt5 (for UnSurf)
* python-opengl (for UnSurf)
* mpv (for BGM)

## Usage

```bash
autoscroll-text [-m] [-b browser_command] sourcefile
```

You can use `$autoscroll_text_overide_browser` environment paramater instead of `-b` option.

`surf` is used by default.

If you use `-m` option, sourcefile is treated as Pandoc's input format (e.g. Markdown).

## Shortcut keys

|Key / Button|Behavior|
|------------|---------------------|
|Space / Mouse right button|Pause / Play|
|Up Arrow|Speed up|
|Down Arrow|Speed down|

## Configuration

`autoscroll-text` is under`XDG_CONFIG_HOME` .

You can configurate looks by editing `scrollingtext.css` .

If you are expart. You can configurate behavior by editing `scrollingtext.js` .

If `BGM` directory is exists under the directory, script plays it with mpv.

## Install

You can install with install script (UnSurf too.)

This script will be installed for user.
Script file will be put under `~/bin` .

# UnSurf

## Description

Ultimate simple webbrowser with qtwebengine.

You can use this program if you don't use Surf.

## Usage

```bash
unsurf.py url
```
