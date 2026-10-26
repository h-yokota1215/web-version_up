# juchu01 ver.2 変更対象一覧

## 1. 開発対象

実装時の対象は、`juchu01`をコピーして作成する`juchu02`である。`juchu01`は変更しない。

| 種類 | 対象 | 方針 |
|---|---|---|
| Java | `ShohinCategory.java` | 商品コードのカテゴリ・サブカテゴリ抽出仕様を確認・修正 |
| Java | `DaoControl.java` | `03`～`05`の詳細DAO振り分けを追加 |
| Java | `JuchuControl.java` | `詳細03`～`詳細05`の画面遷移を追加 |
| Java | `Foods.java`、`Av.java`、`Pc.java` | 新規モデルクラスを追加 |
| Java | `DaoFoods.java`、`DaoAv.java`、`DaoPc.java` | 新規カテゴリの詳細取得DAOを追加 |
| JSP | `cosd1042.jsp`、`cosd1043.jsp`、`cosd1044.jsp` | 既存`cosd1040.jsp`・`cosd1041.jsp`の配置・構造を踏襲して追加 |
| SQL | `sql/ver.2/create.sql` | `COSCOMMON02`用のテーブル定義を追加 |
| SQL | `sql/ver.2/insert.sql` | カテゴリ・サブカテゴリ・商品・在庫データを追加 |
| SQL | `sql/ver.2/select.sql` | 件数・コード・在庫・画像URIの確認SQLを追加 |
| 画像 | `juchu02/WebContent/img/foods`等 | サンプル画像を配置 |

## 2. 原則変更しないファイル

- `juchu01`配下のJava、JSP、HTML、設定ファイル
- 既存の文具・書籍用`cosd1040.jsp`、`cosd1041.jsp`
- 既存の共通商品一覧画面。ただし、設計レビューで変更が必要と判断した場合は対象範囲を記録する。

## 3. コメントルール

### Java

```java
// ***** ここから ver.2: 商品コード03～05のDAO振り分けを追加
// 作業内容: 食品・AV機器・PCの詳細DAOを選択する
// ***** ここまで ver.2
```

### JSP・HTML

画面要素の変更はHTMLコメントで囲む。JSPスクリプトレット内のJava処理はJavaコメントで囲む。

```jsp
<!-- ***** ここから ver.2: 食品固有項目を表示 -->
<!-- 作業内容: 食品の味・内容量・製造国を表示する -->
<!-- ***** ここまで ver.2 -->
```

```jsp
<% // ***** ここから ver.2: 食品詳細データを取得
   // 作業内容: Foods型の商品情報を画面表示へ渡す
   // ***** ここまで ver.2 %>
```

### SQL

SQLは`sql/README.md`のルールに従い、追加・変更したDDL、INSERT、SELECTブロックごとに日本語コメントを付ける。

## 4. 実装結果確認

- [x] `juchu02`のコンテキスト・ルートが`juchu02`になっている
- [x] DB接続先が`COSCOMMON02`になっている
- [x] `juchu01`に変更が入っていない
- [x] 新規・変更Javaにver.2コメントがある
- [x] 新規・変更JSP・HTMLにver.2コメントがある
- [x] SQLの変更ブロックにver.2コメントがある
- [x] 新規画面が既存画面の配置・CSS・遷移方式に準拠している

Java、JSP、SQL、画像の配置確認と、Tomcat上の画面遷移確認を完了した。
