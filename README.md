# libandroid-shmem-termux.so -- Termux の開発コミュニティよって移植された libandroid-shmem.so を Debian noroot 環境に再移植した動的ライブラリ

## 概要

動的ライブラリ ```libandroid-shmem.so``` は、 [Debian noroot 環境][DBNR] の作者である [pelya 氏][PELY]によって作成された、 共有メモリ関連の標準ライブラリ関数を ```/dev/ashmem``` によってエミュレートする [Debian noroot 環境][DBNR]のための動的ライブラリである [libandroid-shmem.so][PSHM] について、 [Termux の開発コミュニティ][TMUX]が [Termux 環境に対応するように移植したもの][TSHM]を、更に [Debian noroot 環境][DBNR]上で動作するように再移植した動的ライブラリです。

即ち、動的ライブラリ ```libandroid-shmem.so``` は、 [Termux の開発コミュニティ][TMUX]によって作成された [Termux 環境に対応するよう移植した ```libandroid-shmem.so```][TSHM] に、 "[Termux に移植された ```libandroid-shmem.so``` を Debian noroot 環境に再移植するための差分ファイル][GST1]" を適用したものです。

## ビルド及びインストール

```libandroid-shmem.so``` のビルドには通常の make を使用します。先ずは、カレントディレクトリを Makefile が置かれているディレクトリに移動します。そして、以下の通りに make コマンドを実行します。

```
 $ cd /path/to/libandroid-shmem-termux  # (ここに、/path/to/libandroid-shmem-termux は、 libandroid-shmem-termux.so のソースコードが置かれているディレクトリ)
 $ make
```

ここで、以下のように ```make``` コマンドの引数に ```CC=...``` を指定すると、 ```libandroid-shmem.so``` のビルドの際に使用する C コンパイラを指定できます。これは、クロスコンパイルを行う際に有用です。

```
 $ make CC=/path/to/x86_64-linux-gnu-gcc  # (ここに、/path/to/x86_64-linux-gnu-gcc は、 libandroid-shmem-termux.so をビルドする際に使用する C コンパイラが置かれているパス)
```

そして、 ```libandroid-shmem.so``` のビルドが完了した後は、以下のようにして、 ```libandroid-shmem.so``` を [Debian noroot 環境][DBNR]のルートディレクトリにインストールします。

```
 $ sudo install -v -m 0755 libandroid-shmem-termux.so /
```
## Debian noroot 環境への設定方法

```libandroid-shmem.so``` 内のライブラリ関数を [Debian noroot 環境][DBNR]にて使用するには、以下のように、環境変数 ```LD_PRELOAD``` に ```libandroid-shmem.so``` の置かれているパスを設定し、各種アプリケーションを起動します。

即ち、 [Debian noroot 環境][DBNR] の初期化ファイルである ```/proot.sh``` において、環境変数 ```LD_PRELOAD``` が定義されている行を以下のように修正します。

```
# LD_PRELOAD="... /libandroid-shmem.so ..."
LD_PRELOAD="... /libandroid-shmem-termux.so ..."    # /libandroid-shmem.so を /libandroid-shmem-termux.so に修正。
```
初期化ファイル ```/proot.sh``` の修正後は、 [Debian noroot 環境][DBNR]を再起動して設定を有効にします。

## libandroid-shmem-termux.so で使用する環境変数

ここに、本差分ファイルを適用して生成した動的ライブラリ ```libandroid-shmem-termux.so``` において使用する環境変数について述べます。

### ```LIBANDROID_SHMEM_QUIET```

環境変数 ```LIBANDROID_SHMEM_QUIET``` の値を 1 に設定すると、動的ライブラリ ```libandroid-shmem-termux.so``` が ```stderr``` に出力するデバッグ用のログの出力を抑止します。

### ```LIBANDROID_SHMEM_DISABLE```

環境変数 ```LIBANDROID_SHMEM_DISABLE``` の値を 1 に設定すると、共有メモリ関連の標準ライブラリ関数である ```shmget(), shmat(), shmdt(), shmctl()``` を一時的に無効化します。一部のソフトウェアについて、この動的ライブラリの為に動作が不安定になる場合は、この環境変数の設定を試みて下さい。

## 謝辞

まず最初に、 [Debian noroot 環境][DBNR]及びそれに伴う ```libandroid-shmem.so``` を開発した [pelya 氏][PELY]に心より感謝致します。また、 ```libandroid-shmem.so``` の機能を強化して Termux 環境に移植した [termux の開発コミュニティ][TMUX]に心より感謝致します。

そして、 [Debian noroot 環境][DBNR]及び [Termux 環境][TMUX]に関わる全ての人々に心より感謝致します。

## 配布条件

本リポジトリは、 [pelya 氏][PELY]によって作成された、 共有メモリ関連の標準ライブラリ関数を ```/dev/ashmem``` によってエミュレートする [Debian noroot 環境][DBNR]のための動的ライブラリである [libandroid-shmem.so][PSHM] を基に、 [Termux の開発コミュニティ][TMUX]が [Termux 環境に対応するように移植したもの][TSHM]を、更に [Z.OOL. (mailto:zool@zool.jpn.org)][ZOOL] によって [Debian noroot 環境][DBNR]上で動作するように再移植したものです。

従って、本リポジトリ及び本リポジトリによって生成される動的ライブラリ ```libandroid-shmem.so``` は、 [pelya 氏][PELY]と [Termux の開発コミュニティの関係各位][TMUX]及び [Z.OOL. (mailto:zool@zool.jpn.org)][ZOOL] が著作権を有し、 [Termux の開発コミュニティによる ```libandroid-shmem.so```][TSHM] と同様に [BSD 3-Clause License][BSD3] に基づいて配布されるものとします。詳細については、本リポジトリに同梱する ```LICENSE``` を参照して下さい。

## 追記

下記に、 [Termux の開発コミュニティによる ```libandroid-shmem.so```][TSHM] の README.md の原文を示します。

----

libandroid-shmem
================
System V shared memory (shmget, shmat, shmdt and shmctl) emulation on Android using ashmem for use in [Termux](https://termux.com/).

The shared memory segments it creates will be automatically destroyed when the creating process destroys them or dies, which differs from the System V shared memory behaviour.

Based on previous work in https://github.com/pelya/android-shmem.

Hacking
=======
The project can be developed on Android devices using Termux. Clone the repo and run `make` in the `tests/` folder after editing the library or test cases.

<!-- 外部リンク一覧 -->

[DBNR]:https://play.google.com/store/apps/details?id=com.cuntubuntu&hl=ja                                                                         
[ANDR]:https://www.android.com/intl/ja_jp/
[DEBI]:https://www.debian.org/index.ja.html
[PELY]:https://github.com/pelya
[TMUX]:https://termux.com/
[PSHM]:https://github.com/pelya/android-shmem
[TSHM]:https://github.com/termux/libandroid-shmem
[GST1]:https://gist.github.com/z80oolong/247dbbb0a7d83a1dea98de2939327432
[ZOOL]:http://zool.jpn.org/
[BSD3]:https://opensource.org/licenses/BSD-3-Clause
