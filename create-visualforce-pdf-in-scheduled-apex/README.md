Force.com Migration Tool Scaffold
=================================

Force.com Migration Tool (Force.com 移行ツール) を使用するための初期ファイル群です。

http://dackdive.hateblo.jp/entry/2015/03/01/133827

### 基本的な使い方 (ant をそのまま使用した deploy & retrieve)

- 事前に Force.com Migration Tool をインストール
	- https://help.salesforce.com/apex/HTViewSolution?id=000176910&language=ja
- `build.properties.sample` に自分の組織のusername, password を入力し、`build.properties` として保存
- `build.xml` に記載されたコマンドを実行
	- `retrieveCode`: コードを取得
	- `deployCode`: コードをデプロイ
	- `removeCode`: コードを削除

### シェルスクリプトを利用した deploy & retrieve

同梱されている `deploy.sh`, `retrieve.sh` というシェルスクリプトを使うと  
デプロイ先組織やデプロイ対象のディレクトリを指定することが可能です。

`build.properties` と同じ内容のファイルを用意し、オプション引数で指定します。

```zsh
$ ./deploy.sh -p [プロパティファイル名] -t [デプロイ対象のディレクトリ]
```
(`retrieve.sh` も同様)

- デプロイ対象のディレクトリとその中の `package.xml` は事前に作成済みとします。
- 各オプションは省略が可能です。その場合は `build.xml` の冒頭に記載した  
デフォルトのプロパティファイル (`build.properties`) とディレクトリ (`codepkg` または `retrievecodepkg`) を使用します。

### 代表的なメタデータ

コードをデプロイするときは、ファイルの種類に応じて適切なディレクトリの下に作成してください

| ファイル  | ディレクトリ名 | 拡張子名 | ```package.xml```の```<name>``` |
|:--|:-:|:-:|:-:|
|Apexクラス|classes|.cls|ApexClass|
|Apexトリガ|triggers|.trigger|ApexTrigger|
|Visualforceページ|pages|.page|ApexPage|
|オブジェクト（標準・カスタム）|objects|.object|CustomObject|
|カスタム表示ラベル|labels|.labels|CustomLabels|
|カスタムタブ|tabs|.tab|CustomTab|
|翻訳ファイル|translations|.translation|Translations|
