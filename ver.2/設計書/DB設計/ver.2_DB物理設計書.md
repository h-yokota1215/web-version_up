# juchu01 ver.2 DB物理設計書

## DB物理設計書／テーブル定義書

| システム名 | COSシステム | 作成日 | 2026/10/23 | 更新日 | 2026/10/23 |
|---|---|---|---|---|---|
| サブシステム名 | 受注サブシステム | 作成者 | 開発担当 | 更新者 | 開発担当 |

対象DB：H2 `COSCOMMON02`　対象プロジェクト：`juchu02`　対象バージョン：ver.2

凡例：PK＝主キー、NN＝`NOT NULL`、FK＝外部キーまたは論理的な参照先

## 1. FOODS_TABLE

| No. | 項目名 | DB項目名 | データ型 | PK | NN | FK | 備考 |
|---:|---|---|---|:---:|:---:|:---:|---|
| 1 | 商品コード | `GOODSCD` | `CHAR(14)` | ○ |  |  | 食品商品を一意に識別 |
| 2 | 商品名 | `GOODSNAME` | `VARCHAR(60)` |  | ○ |  | 食品名 |
| 3 | 入り数 | `IRISU` | `INT(4)` |  | ○ |  | 販売単位あたりの数量 |
| 4 | 単位 | `TANNI` | `VARCHAR(6)` |  | ○ |  | 個、箱など |
| 5 | 販売単価 | `H_TANKA` | `INT(6)` |  | ○ |  | 商品単価 |
| 6 | メーカーコード | `MAKERCD` | `CHAR(3)` |  | ○ | ○ | `MAKER_TABLE.MAKERCD` |
| 7 | コメント | `COMMENT` | `TEXT` |  |  |  | 商品説明 |
| 8 | 画像URI | `IMG_URI` | `VARCHAR(50)` |  |  |  | `img/foods`の画像と対応 |
| 9 | 商品種別 | `SHUBETU` | `VARCHAR(15)` |  | ○ |  | 商品種別 |
| 10 | 味 | `TASTE` | `VARCHAR(50)` |  |  |  | 食品固有項目 |
| 11 | 内容量 | `CONTENT` | `VARCHAR(50)` |  |  |  | 食品固有項目 |
| 12 | 製造国 | `COUNTRY` | `VARCHAR(50)` |  |  |  | 食品固有項目 |
| 13 | 熱量 | `CALORIE` | `VARCHAR(30)` |  |  |  | 食品固有項目 |
| 14 | 原材料 | `INGREDIENT` | `TEXT` |  |  |  | 食品固有項目 |
| 15 | 栄養成分 | `NUTRIENTS` | `TEXT` |  |  |  | 食品固有項目 |
| 16 | その他 | `OTHER` | `TEXT` |  |  |  | 補足情報 |

## 2. AV_TABLE

| No. | 項目名 | DB項目名 | データ型 | PK | NN | FK | 備考 |
|---:|---|---|---|:---:|:---:|:---:|---|
| 1 | 商品コード | `GOODSCD` | `CHAR(14)` | ○ |  |  | AV商品を一意に識別 |
| 2 | 商品名 | `GOODSNAME` | `VARCHAR(60)` |  | ○ |  | 商品名 |
| 3 | 入り数 | `IRISU` | `INT(4)` |  | ○ |  | 販売単位あたりの数量 |
| 4 | 単位 | `TANNI` | `VARCHAR(6)` |  | ○ |  | 個、台など |
| 5 | 販売単価 | `H_TANKA` | `INT(6)` |  | ○ |  | 商品単価 |
| 6 | メーカーコード | `MAKERCD` | `CHAR(3)` |  | ○ | ○ | `MAKER_TABLE.MAKERCD` |
| 7 | コメント | `COMMENT` | `TEXT` |  |  |  | 商品説明 |
| 8 | 画像URI | `IMG_URI` | `VARCHAR(50)` |  |  |  | `img/av`の画像と対応 |
| 9 | 商品種別 | `SHUBETU` | `VARCHAR(15)` |  | ○ |  | 商品種別 |
| 10 | 色 | `COLOR` | `VARCHAR(10)` |  |  |  | AV固有項目 |
| 11 | 型番 | `KATABAN` | `VARCHAR(30)` |  |  |  | AV固有項目 |
| 12 | 画面サイズ | `SCREEN_SIZE` | `VARCHAR(30)` |  |  |  | AV固有項目 |
| 13 | 画面解像度 | `SCREEN_RESOLUTION` | `VARCHAR(30)` |  |  |  | AV固有項目 |
| 14 | 出力音量 | `OUTPUT_VOLUME` | `VARCHAR(30)` |  |  |  | AV固有項目 |
| 15 | 容量 | `CAPACITY` | `VARCHAR(30)` |  |  |  | AV固有項目 |
| 16 | メディア | `MEDIA` | `VARCHAR(50)` |  |  |  | AV固有項目 |
| 17 | インターフェース | `INTERFACE` | `VARCHAR(100)` |  |  |  | AV固有項目 |
| 18 | 消費電力 | `POWER_CONSUMPTION` | `VARCHAR(30)` |  |  |  | AV固有項目 |
| 19 | 付属品 | `ACCESSORIES` | `VARCHAR(100)` |  |  |  | AV固有項目 |
| 20 | 保証 | `WARRANTY` | `VARCHAR(30)` |  |  |  | AV固有項目 |
| 21 | 質量 | `WEIGHT` | `VARCHAR(30)` |  |  |  | AV固有項目 |
| 22 | 寸法 | `SIZE` | `VARCHAR(100)` |  |  |  | AV固有項目 |
| 23 | その他 | `OTHER` | `TEXT` |  |  |  | 補足情報 |

## 3. PC_TABLE

| No. | 項目名 | DB項目名 | データ型 | PK | NN | FK | 備考 |
|---:|---|---|---|:---:|:---:|:---:|---|
| 1 | 商品コード | `GOODSCD` | `CHAR(14)` | ○ |  |  | PC商品を一意に識別 |
| 2 | 商品名 | `GOODSNAME` | `VARCHAR(60)` |  | ○ |  | 商品名 |
| 3 | 入り数 | `IRISU` | `INT(4)` |  | ○ |  | 販売単位あたりの数量 |
| 4 | 単位 | `TANNI` | `VARCHAR(6)` |  | ○ |  | 個、台など |
| 5 | 販売単価 | `H_TANKA` | `INT(6)` |  | ○ |  | 商品単価 |
| 6 | メーカーコード | `MAKERCD` | `CHAR(3)` |  | ○ | ○ | `MAKER_TABLE.MAKERCD` |
| 7 | コメント | `COMMENT` | `TEXT` |  |  |  | 商品説明 |
| 8 | 画像URI | `IMG_URI` | `VARCHAR(50)` |  |  |  | `img/pc`の画像と対応 |
| 9 | 商品種別 | `SHUBETU` | `VARCHAR(15)` |  | ○ |  | 商品種別 |
| 10 | 色 | `COLOR` | `VARCHAR(10)` |  |  |  | PC固有項目 |
| 11 | 型番 | `KATABAN` | `VARCHAR(30)` |  |  |  | PC固有項目 |
| 12 | 画面サイズ | `SCREEN_SIZE` | `VARCHAR(30)` |  |  |  | PC固有項目 |
| 13 | 画面解像度 | `SCREEN_RESOLUTION` | `VARCHAR(30)` |  |  |  | PC固有項目 |
| 14 | CPU | `CPU` | `VARCHAR(50)` |  |  |  | PC固有項目 |
| 15 | メモリ | `MEMORY` | `VARCHAR(30)` |  |  |  | PC固有項目 |
| 16 | HDD | `HDD` | `VARCHAR(30)` |  |  |  | PC固有項目 |
| 17 | ドライブ | `DRIVE` | `VARCHAR(100)` |  |  |  | PC固有項目 |
| 18 | ネットワーク | `NETWORK` | `VARCHAR(50)` |  |  |  | PC固有項目 |
| 19 | OS | `OS` | `VARCHAR(100)` |  |  |  | PC固有項目 |
| 20 | 統合ソフト | `SOFTWARE` | `VARCHAR(100)` |  |  |  | PC固有項目 |
| 21 | バッテリ | `BATTERY` | `VARCHAR(50)` |  |  |  | PC固有項目 |
| 22 | 付属品 | `ACCESSORIES` | `VARCHAR(100)` |  |  |  | PC固有項目 |
| 23 | 保証 | `WARRANTY` | `VARCHAR(30)` |  |  |  | PC固有項目 |
| 24 | 質量 | `WEIGHT` | `VARCHAR(50)` |  |  |  | PC固有項目 |
| 25 | 寸法 | `SIZE` | `VARCHAR(100)` |  |  |  | PC固有項目 |
| 26 | その他 | `OTHER` | `TEXT` |  |  |  | 補足情報 |

## 4. 関連テーブルと論理制約

| 関連テーブル | 連携項目 | 用途 |
|---|---|---|
| `CTR_GCTG_TABLE` | 商品コード先頭2桁 = `GCTGCD` | `03`食品、`04`AV機器、`05`PCのカテゴリ判定 |
| `GSUBCTG_TABLE` | 商品コード先頭4桁 = `GSUBCTGCD` | サブカテゴリ名称の取得 |
| `MAKER_TABLE` | `MAKERCD` | メーカー名称の取得 |
| `HANBAIZAIKO01_TABLE`～`03_TABLE` | `GOODSCD`、`EIGYOUSHOCD` | 営業所別在庫・引当数の取得 |

※ `MAKERCD`は既存DDL上で外部キー制約を明示していないため、FK欄は論理的な参照関係を示す。

## 5. 登録件数

| テーブル | 登録件数 |
|---|---:|
| `FOODS_TABLE` | 4 |
| `AV_TABLE` | 4 |
| `PC_TABLE` | 3 |
| `HANBAIZAIKO01_TABLE` | 11 |
| `HANBAIZAIKO02_TABLE` | 11 |
| `HANBAIZAIKO03_TABLE` | 11 |
