Force.com Migration Tool Scaffold
=================================

Force.com Migration Tool (Force.com 移行ツール) を使用するための初期ファイル群です。

### 使い方

- 事前に Force.com Migration Tool をインストール
	- https://help.salesforce.com/apex/HTViewSolution?id=000176910&language=ja
- `build.properties.sample` に自分の組織のusername, password を入力し、`build.properties` として保存
- `build.xml` に記載されたコマンドを実行
	- `retrieveCode`: コードを取得
	- `deployCode`: コードをデプロイ
	- `removeCode`: コードを削除

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
