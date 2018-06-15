# autoscrolling-text

自動スクロールするテキストリーダー

## 説明

テキストからHTMLを生成し、JavaScriptを利用して自動スクロールを実現する。

ページの表示には標準でSurfを使用する。

## 依存

* Zsh
* Pandoc (Markup mode利用時)
* Surf (デフォルトブラウザ利用時)
* Python (UnSurf利用時)
* PyQt5 (UnSurf利用時)
* python-opengl (UnSurf利用時)
* mpv (BGM再生時)

## 使い方

```bash
autoscroll-text [-m] [-b browser_command] sourcefile
```

`$autoscroll_text_overide_browser` という環境変数を `-b` オプションの代わりに利用することもできる。
指定しなければ`surf`が使われる。

`-m` オプションをつけるとsourcefileは通常のテキストではなくPandocが理解できる形式(MarkdownやReStructured Textなど)だとみなす。

## キー設定

|キー|動作|
|--------|------------------|
|スペース/右クリック|一時停止/再生|
|↑キー|速度+|
|↓キー|速度-|

## 設定

`XDG_CONFIG_HOME` 以下に `autoscroll-text` というディレクトリがある。

`scrollingtext.css` によって見た目を設定することができる。

あなたがもし上級者なら `scrollingtext.js` を編集することで挙動を調整することもできる。

また、同ディレクトリに `BGM` というディレクトリがある場合再生される。

## インストール

UnSurfとともにそれぞれインストールスクリプトを実行すればインストールされるが、ユーザー単位で実行されることを前提としている。

実行ファイルは `~/bin` 以下に配置される。

# UnSurf

## 説明

Surfをインストールしたくない、あるいはインストールできない人のためのブラウザである。

ごく単純にQtwebengineを用いてページを表示する。

## 使い方

```bash
unsurf.py url
```
