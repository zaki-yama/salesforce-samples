# [構成 - Salesforce Lightning Component Library](https://developer.salesforce.com/docs/component-library/documentation/ja-jp/lwc/lwc.create_components_compose_intro)

- オーナー
  - composited component の公開プロパティを設定する
  - composited component でメソッドをコールする
  - composited component によって起動されるイベントをリッスンする
- コンテナ
  - 含まれているコンポーネントの公開プロパティを読み取る（変更は不可）
  - composited component でメソッドをコールする（？）
  - 含まれているコンポーネントによって上に伝達された一部のイベント (必ずしもすべてではない) をリッスンする
- 親と子

### データフロー

- 子コンポーネントは `@api` でフィールドを公開プロパティとして公開する
  - フィールドを初期化するときのみ値が設定される
  - オーナーコンポーネントでのみ値が設定でき、子コンポーネントでは参照のみ（一方向データバインド）
- コンポーネントに渡されるオブジェクトは参照のみ
- 公開プロパティはプリミティブ値がおすすめ
  - プリミティブ値のみとすることでデータ構造が明確になる（オブジェクトや配列を受け取る場合、どんな構造になってるか別途ドキュメントが必要）
  - 標準の HTML 要素はプリミティブ値しか属性で受け取れない

### 子コンポーネントでのメソッドのコール

```html
<!-- parent.html -->
<template>
  <div>
    <c-child />
    <button onclick="{handleClick}">Pause</button>
  </div>
</template>
```

```javascript
// parent.js
import { LightningElement } from "lwc";

export default class Parent extends LightningElement {
  handleClick() {
    this.template.querySelector("c-child").foo();
  }
}
```

こんな感じで、親からは `this.template.querySelector()` で子コンポーネントを取得し、子のメソッド (`foo()`) を呼び出すことができる

- `id` を `querySelector` などに渡すのは NG とされている。 `id` がグローバルで一意な値に変換される場合があるため

### スロットにマークアップを渡す

- 子コンポーネントに `<slot>` があると、親からはそこに対して任意のコンポーネントを渡すことができる。
- 名前なしスロットと名前付きスロットがある

```html
<!-- 名前つきスロットのサンプル: 子 -->
<template>
  <p>First Name: <slot name="firstName">Default first name</slot></p>
  <p>Last Name: <slot name="lastName">Default last name</slot></p>
  <p>Description: <slot>Default description</slot></p>
</template>
```

```html
<!-- 名前つきスロットのサンプル: 親 -->
<template>
  <c-named-slots>
    <span slot="firstName">Willy</span>
    <span slot="lastName">Wonka</span>
    <span>Chocolatier</span>
  </c-named-slots>
</template>
```

> ただし、スロットに渡される DOM 要素は、コンポーネントのシャドウツリーの一部ではありません。

これ、Web Components のことちゃんと理解できてなくてよくわからなかった。
スロットに渡される場合通常の DOM のツリーと違うものとして扱われるんだっけ？

- `<slot>` にのみ `slotchange` イベントがサポートされている
  - `<slot>` の直接の子が変更されると `slotchange` イベントが発火する
