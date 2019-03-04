# About

mermaidjsのコマンドラインインターフェースである、
mermaid-cliの動作イメージを日本語対応したイメージです。

ベースとなったイメージは以下となります。
ただし、日本語フォントがないため、日本語を含んだファイルを変換んしようとすると文字化けしていました。
本イメージでは日本語フォントを含ませて日本語を含むファイルも変換できるようにしています。

https://github.com/jnewland/mermaid.cli


## Installation

```
docker pull yamada28go/mermaid.cli.jp
```


## Examples

```
docker run --rm -v マウントパス:/local yamada28go/mermaid.cli.jp -i /local/対象ファイル.md -o /local/出力ファイル.png
```

```
docker run --rm -v マウントパス:/local yamada28go/mermaid.cli.jp -i /local/対象ファイル.md -o /local/output.pdf
```

```
docker run --rm -v マウントパス:/local yamada28go/mermaid.cli.jp -i /local/対象ファイル.md -o /local/output.svg -w 1024 -H 768
```

```
docker run --rm -v マウントパス:/local yamada28go/mermaid.cli.jp -i /local/対象ファイル.md -o /local/forest
```

```
docker run --rm -v マウントパス:/local yamada28go/mermaid.cli.jp -i /local/対象ファイル.md -o /local/output.png -b '#FFF000'
```

```
docker run --rm -v マウントパス:/local yamada28go/mermaid.cli.jp -i /local/対象ファイル.md -o /local/output.png -b transparent
```


## Options

Please run the following command to see the latest options:

```
docker run --rm yamada28go/mermaid.cli.jp  -h
```

The following is for your quick reference (may not be the latest version):

```
Usage: mmdc [options]


  Options:

    -V, --version                            output the version number
    -t, --theme [name]                       Theme of the chart, could be default, forest, dark or neutral. Optional. Default: default
    -w, --width [width]                      Width of the page. Optional. Default: 800
    -H, --height [height]                    Height of the page. Optional. Default: 600
    -i, --input <input>                      Input mermaid file. Required.
    -o, --output [output]                    Output file. It should be either svg, png or pdf. Optional. Default: input + ".svg"
    -b, --backgroundColor [backgroundColor]  Background color. Example: transparent, red, '#F0F0F0'. Optional. Default: white
    -c, --configFile [config]                JSON configuration file for mermaid. Optional
    -C, --cssFile [cssFile]                  CSS alternate file for mermaid. Optional
    -h, --help                               output usage information
```
