# pitanano-galaxy: Nanoporeデータ解析用のGalaxy

## 概要

コンテナ型環境のDocker版Galaxy環境にNanoporeデータ解析用のツールを組み込んだGalaxyを構築しました。Docker版Galaxyの[docker-galaxy-stable](https://github.com/bgruening/docker-galaxy-stable)をベースに、IlluminaとMinION用の各種ツールをGUIで使用できるようにGalaxyに組み込んでいます。

使用可能なツールは以下です。

- リードのQC
  - FastQC
  - Trimmomatic
  - NanoPlot
  - Porechop
- FASTQファイルの操作
  - seqtk
- メタゲノム解析
  - Centrifuge
  - Krona
- マッピング
  - BWA-MEM
- De novoアセンブル
  - Unicycler
  - Canu

上記の他にもGalaxy ToolShedに登録されている様々なNGS解析ツールがGalaxy環境に追加インストール可能です。

## 準備

[Docker](https://www.docker.com)をインストールしていない場合は最初にインストールします。

コンテナ内へのファイル書き込みをホスト側のMacに保存するために、Data volumeコンテナを最初に作成する。

```
$ docker create -v /export --name galaxy-store \
 youyuh48/pitanano-galaxy /bin/true
```

## 動かす

```
$ docker run -d -p 8080:80 \
 --volumes-from galaxy-store \
 youyuh48/pitanano-galaxy:0.1 \
 /usr/bin/startup
```

ブラウザから `http://localhost:8080` を開くとGalaxyにアクセスできる。
他のマシンからアクセスするには `http://ホストのIPアドレス:8080`

## コンテナの停止

`$ docker stop <CONTAINER ID>`

停止したコンテナは`docker start`で再開します。
