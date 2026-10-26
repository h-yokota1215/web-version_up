# juchu01 ver.2 詳細設計書

## 0. 開発対象

本設計は`juchu02`を対象とする。`juchu01`はVer.1の基準プロジェクトとして変更しない。DB接続先はH2の`COSCOMMON02`とし、コンテキスト・ルートは`juchu02`とする。

## 1. DB詳細設計

### 1.1 共通列

新商品テーブルは、既存`BUNGU_TABLE`・`BOOK_TABLE`に合わせて次の共通列を持つ。

| 列 | 型・制約 | 備考 |
|---|---|---|
| `GOODSCD` | `CHAR(14) PRIMARY KEY` | 商品コード |
| `GOODSNAME` | `VARCHAR(60) NOT NULL` | 商品名 |
| `IRISU` | `INT(4) NOT NULL` | 入数 |
| `TANNI` | `VARCHAR(6) NOT NULL` | 単位 |
| `H_TANKA` | `INT(6) NOT NULL` | 販売単価 |
| `MAKERCD` | `CHAR(3) NOT NULL` | メーカーコード |
| `COMMENT` | `TEXT` | 商品コメント |
| `IMG_URI` | `VARCHAR(50)` | 商品画像URI |
| `SHUBETU` | `VARCHAR(15) NOT NULL` | 商品種別 |
| `OTHER` | `TEXT` | その他 |

### 1.2 食品テーブル

`FOODS_TABLE`に共通列と次の固有列を定義する。

| 列 | 型 | Excel項目 |
|---|---|---|
| `TASTE` | `VARCHAR(50)` | 味 |
| `CONTENT` | `VARCHAR(50)` | 内容量 |
| `COUNTRY` | `VARCHAR(50)` | 製造国 |
| `CALORIE` | `VARCHAR(30)` | 熱量 |
| `INGREDIENT` | `TEXT` | 原材料 |
| `NUTRIENTS` | `TEXT` | 栄養成分 |

### 1.3 AV機器テーブル

`AV_TABLE`に共通列と次の固有列を定義する。

`COLOR`、`KATABAN`、`SCREEN_SIZE`、`SCREEN_RESOLUTION`、`OUTPUT_VOLUME`、`CAPACITY`、`MEDIA`、`INTERFACE`、`POWER_CONSUMPTION`、`ACCESSORIES`、`WARRANTY`、`WEIGHT`、`SIZE`。

### 1.4 PCテーブル

`PC_TABLE`に共通列と次の固有列を定義する。

`COLOR`、`KATABAN`、`SCREEN_SIZE`、`SCREEN_RESOLUTION`、`CPU`、`MEMORY`、`HDD`、`DRIVE`、`NETWORK`、`OS`、`SOFTWARE`、`BATTERY`、`ACCESSORIES`、`WARRANTY`、`WEIGHT`、`SIZE`。

### 1.5 カテゴリ・在庫データ

- `CTR_GCTG_TABLE`へ`03/Foods`、`04/Av`、`05/Pc`を登録する。
- `GSUBCTG_TABLE`へ商品コード先頭4桁に合わせた`0301`～`0303`、`0401`～`0405`、`0501`を登録する。Excelの`301`、`401`、`501`は表示元のサブカテゴリ番号として扱い、DB登録時にカテゴリコードを付加する。
- `MAKER_TABLE`のメーカーコード`003`～`008`は既存初期データを確認して利用する。未登録の場合のみ追加し、重複登録は行わない。
- `HANBAIZAIKO01_TABLE`～`HANBAIZAIKO03_TABLE`へExcelの11商品分を登録する。
- 商品画像は`WebContent/img/foods`、`WebContent/img/av`、`WebContent/img/pc`へ配置する。

## 2. Javaクラス設計

### 2.1 データモデル

| クラス | 継承 | 役割 |
|---|---|---|
| `Foods` | `Shohin` | 食品固有項目を保持 |
| `Av` | `Shohin` | AV機器固有項目を保持 |
| `Pc` | `Shohin` | PC固有項目を保持 |

各クラスにはExcel項目に対応するprivateフィールド、getter、setterを追加する。画面表示用の値は文字列として保持し、単位付きの値（例：32V型、1TB、1年）は入力値を欠落させない。

### 2.2 DAO

| クラス | 役割 |
|---|---|
| `DaoFoods` | `FOODS_TABLE`から食品の詳細を取得 |
| `DaoAv` | `AV_TABLE`からAV機器の詳細を取得 |
| `DaoPc` | `PC_TABLE`からPCの詳細を取得 |
| `DaoShohin` | 新カテゴリの一覧取得で共通列を取得 |
| `DaoControl` | 商品コード先頭2桁とDAOの振り分けを拡張 |

### 2.3 振り分け処理

```text
商品コード長 = 4
  -> DaoShohinでサブカテゴリ一覧を取得

商品コード長 = 14
  -> 先頭2桁が01 -> DaoBungu
  -> 先頭2桁が02 -> DaoBook
  -> 先頭2桁が03 -> DaoFoods
  -> 先頭2桁が04 -> DaoAv
  -> 先頭2桁が05 -> DaoPc
```

未対応のコードの場合はDAOを生成せず、既存のエラー遷移へ渡す。nullのDAOで処理を続行しない。

## 3. 画面設計

### 3.1 商品一覧 `cosd1020.jsp`

- カテゴリ選択肢はDBから取得するため、画面の固定追加は行わない。
- 新カテゴリでも商品コード、商品名、メーカー、入数、単価、在庫表示を共通表示する。
- 詳細ボタンには商品コードを保持する。
- カート追加時は既存の`ShohinPrimalData`を利用する。

### 3.2 商品詳細

現行の`cosd1040.jsp`（文具）、`cosd1041.jsp`（書籍）の配置・命名・遷移方式を維持し、新カテゴリ用の詳細JSPを追加する。

| カテゴリ | 詳細画面 |
|---|---|
| 文具 | `WebContent/cosd1040.jsp`（既存） |
| 書籍 | `WebContent/cosd1041.jsp`（既存） |
| 食品 | `WebContent/cosd1042.jsp`（追加） |
| AV機器 | `WebContent/cosd1043.jsp`（追加） |
| PC | `WebContent/cosd1044.jsp`（追加） |

新JSPは既存詳細JSPのHTML構造、CSS参照、セッションからの商品取得方法、カート追加ボタンの配置を踏襲する。カテゴリ固有項目だけを各JSPで追加表示し、大規模な画面構造変更は行わない。

## 4. 受注処理への影響

- `Meisai`が利用する商品基本情報は既存の`ShohinPrimalData`を使用する。
- 新カテゴリ固有項目は受注明細へ保存せず、商品詳細表示用とする。
- 在庫照会・引当は商品コードをキーに既存`HANBAIZAIKOxx_TABLE`を利用する。
- 新カテゴリの商品コードが既存の14桁形式を満たすことを登録前に検証する。

## 5. 実装順序

1. `COSCOMMON02`へ`sql/ver.2/create.sql`と`sql/ver.2/insert.sql`の定義を適用する。
2. `sql/ver.2/select.sql`で作成結果・件数・コード整合性を確認する。
3. サンプル画像をWebアプリへ配置する。
4. `Foods`、`Av`、`Pc`を追加する。
5. `DaoFoods`、`DaoAv`、`DaoPc`を追加する。
6. `DaoControl`と`JuchuControl`の振り分けを拡張する。
7. 商品詳細画面を拡張する。
8. ver.2テスト仕様追補に沿ってDB・画面・受注を確認する。
9. 文具・書籍の回帰テストを実施する。

## 6. 設計確定事項

本詳細設計に基づくDB、Java、JSP、画像の実装と、単体・結合・統合・回帰テストは完了している。実装結果と判定は`ver.2_作業・振り返り.md`および`ver.2_テスト仕様追補.md`に記録する。

### 6.0 ソース・JSP・HTMLの変更管理

実装時は、作業上の注意②に従い、変更箇所に日本語で作業内容とバージョンを記載する。Javaの処理変更は`//`、JSP・HTMLの画面変更は`<!-- -->`、JSP内のJava処理は`//`、SQLは`--`を使用する。開始・終了コメントは変更範囲を明確に囲む。

変更対象とコメント例は`ver.2_変更対象一覧.md`を正とする。

### 6.1 詳細画面方式

現行のカテゴリ別詳細JSP方式を維持する。`cosd1042.jsp`～`cosd1044.jsp`は、既存詳細JSPのHTML構造・CSS・セッション参照・カート追加処理をコピーして、固有項目だけを差し替える。

### 6.2 コード正規化

| 項目 | Excel表示値 | DB・Javaで扱う値 |
|---|---|---|
| カテゴリコード | `3`、`4`、`5` | `03`、`04`、`05` |
| サブカテゴリコード | `301`、`401`、`501` | `0301`、`0401`、`0501` |
| 営業所コード | `1`、`2`、`3` | `01`、`02`、`03` |

商品コードはExcelの14桁形式をそのまま保持する。表示時にコードを再変換しない。

### 6.3 エラー処理

- サブカテゴリコードが4桁でない場合は商品検索を実行しない。
- 商品コードが14桁でない場合は商品詳細検索を実行しない。
- 先頭2桁が未対応の場合は商品なしとして扱い、既存エラー画面へ遷移する。
- 商品が存在しない場合は`null`のまま後続処理へ渡さず、商品なし画面へ遷移する。
- 画像ファイルが存在しない場合も、商品情報の表示は継続する。
