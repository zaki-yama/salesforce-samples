Trailhead: Custom Metadata Types
================================

[カスタムメタデータ型 | Salesforce Trailhead](https://trailhead.salesforce.com/ja/modules/custom_metadata_types)

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
デフォルトのプロパティファイル (`build.properties`) とディレクトリ (`src`) を使用します。
