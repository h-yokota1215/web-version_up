# juchu01 ver.2 改修詳細

## 1. 対象構成

| 項目 | ver.2構成 |
|---|---|
| Webプロジェクト | `juchu02` |
| コンテキストルート | `/juchu02` |
| DB | H2 `COSCOMMON02` |
| JDBC URL | `jdbc:h2:tcp://localhost/~/coscommon02` |
| DBユーザー | `sa` |
| アプリケーション | Tomcat 9 / Java 11 |
| 基準版 | `juchu01`、`COSCOMMON01` |

## 2. DB詳細設計

テーブル定義の正式な物理設計表は、[ver.2_DB物理設計書.md](../設計/DB設計/ver.2_DB物理設計書.md)に記載する。項目名、DB項目名、データ型、サイズ、PK、NN、FK、備考をテーブル単位で整理している。

### 2.1 追加テーブル共通定義

`FOODS_TABLE`、`AV_TABLE`、`PC_TABLE`は、既存の`BUNGU_TABLE`・`BOOK_TABLE`と同じ共通商品項目を持つ。

| カラム | 型 | NULL | 説明 |
|---|---|---|---|
| `GOODSCD` | `CHAR(14)` | 不可 | 商品コード、主キー |
| `GOODSNAME` | `VARCHAR(60)` | 不可 | 商品名 |
| `IRISU` | `INT(4)` | 不可 | 入り数 |
| `TANNI` | `VARCHAR(6)` | 不可 | 単位 |
| `H_TANKA` | `INT(6)` | 不可 | 販売単価 |
| `MAKERCD` | `CHAR(3)` | 不可 | メーカーコード |
| `COMMENT` | `TEXT` | 可 | 商品コメント |
| `IMG_URI` | `VARCHAR(50)` | 可 | 商品画像URI |
| `SHUBETU` | `VARCHAR(15)` | 不可 | 商品種別 |
| `OTHER` | `TEXT` | 可 | その他情報 |

### 2.2 `FOODS_TABLE`

主キーは`GOODSCD CHAR(14)`。共通項目に次の食品固有項目を追加する。

| カラム | 型 | 説明 |
|---|---|---|
| `TASTE` | `VARCHAR(50)` | 味 |
| `CONTENT` | `VARCHAR(50)` | 内容量 |
| `COUNTRY` | `VARCHAR(50)` | 製造国 |
| `CALORIE` | `VARCHAR(30)` | 熱量 |
| `INGREDIENT` | `TEXT` | 原材料 |
| `NUTRIENTS` | `TEXT` | 栄養成分 |

### 2.3 `AV_TABLE`

主キーは`GOODSCD CHAR(14)`。固有項目はすべて商品仕様を文字列として保持する。

| カラム | 型 | カラム | 型 |
|---|---|---|---|
| `COLOR` | `VARCHAR(10)` | `KATABAN` | `VARCHAR(30)` |
| `SCREEN_SIZE` | `VARCHAR(30)` | `SCREEN_RESOLUTION` | `VARCHAR(30)` |
| `OUTPUT_VOLUME` | `VARCHAR(30)` | `CAPACITY` | `VARCHAR(30)` |
| `MEDIA` | `VARCHAR(50)` | `INTERFACE` | `VARCHAR(100)` |
| `POWER_CONSUMPTION` | `VARCHAR(30)` | `ACCESSORIES` | `VARCHAR(100)` |
| `WARRANTY` | `VARCHAR(30)` | `WEIGHT` | `VARCHAR(30)` |
| `SIZE` | `VARCHAR(100)` | `OTHER` | `TEXT` |

### 2.4 `PC_TABLE`

主キーは`GOODSCD CHAR(14)`。AV機器共通仕様に加え、PC固有仕様を保持する。

| カラム | 型 | カラム | 型 |
|---|---|---|---|
| `COLOR` | `VARCHAR(10)` | `KATABAN` | `VARCHAR(30)` |
| `SCREEN_SIZE` | `VARCHAR(30)` | `SCREEN_RESOLUTION` | `VARCHAR(30)` |
| `CPU` | `VARCHAR(50)` | `MEMORY` | `VARCHAR(30)` |
| `HDD` | `VARCHAR(30)` | `DRIVE` | `VARCHAR(100)` |
| `NETWORK` | `VARCHAR(50)` | `OS` | `VARCHAR(100)` |
| `SOFTWARE` | `VARCHAR(100)` | `BATTERY` | `VARCHAR(50)` |
| `ACCESSORIES` | `VARCHAR(100)` | `WARRANTY` | `VARCHAR(30)` |
| `WEIGHT` | `VARCHAR(50)` | `SIZE` | `VARCHAR(100)` |
| `OTHER` | `TEXT` |  |  |

### 2.5 既存テーブルとの連携

- `CTR_GCTG_TABLE`：商品コード先頭2桁のカテゴリを参照する。ver.2では`03`食品、`04`AV機器、`05`PCを登録する。
- `GSUBCTG_TABLE`：商品コード先頭4桁のサブカテゴリを参照する。
- `MAKER_TABLE`：`MAKERCD CHAR(3)`でメーカー名を取得する。
- `HANBAIZAIKO01_TABLE`～`03_TABLE`：`GOODSCD CHAR(14)`と営業所コードで在庫・引当数を取得する。
- 商品コードは`CHAR(14)`、カテゴリコードは2桁、サブカテゴリコードは4桁、営業所コードは2桁で統一する。

## 3. Javaクラス詳細設計

### 3.1 商品モデル

新規モデルはすべて`cosDataPack.Shohin`を継承し、固有項目を`String`で保持する。各項目に`public getXxx(): String`と`public setXxx(String): void`を定義する。

| クラス | フィールド | メソッド |
|---|---|---|
| `Foods` | `taste`, `content`, `country`, `calorie`, `ingredient`, `nutrients` | 各フィールドのgetter/setter |
| `Av` | `color`, `kataban`, `screenSize`, `screenResolution`, `outputVolume`, `capacity`, `media`, `interfaceValue`, `powerConsumption`, `accessories`, `warranty`, `weight`, `size` | 各フィールドのgetter/setter |
| `Pc` | `color`, `kataban`, `screenSize`, `screenResolution`, `cpu`, `memory`, `hdd`, `drive`, `network`, `os`, `software`, `battery`, `accessories`, `warranty`, `weight`, `size` | 各フィールドのgetter/setter |

継承元の`Shohin`から、共通商品情報、カテゴリ情報、メーカー、画像URI、在庫数、引当数、在庫表示を引き継ぐ。

### 3.2 DAO

| クラス | 継承 | 公開メソッド | 引数 | 戻り値 |
|---|---|---|---|---|
| `DaoFoods` | `DaoShohin` | `selectData` | `String code, String eigyosyoCD` | `ArrayList<Shohin>` |
| `DaoAv` | `DaoShohin` | `selectData` | `String code, String eigyosyoCD` | `ArrayList<Shohin>` |
| `DaoPc` | `DaoShohin` | `selectData` | `String code, String eigyosyoCD` | `ArrayList<Shohin>` |

各DAOは、商品テーブル、カテゴリテーブル、メーカー、営業所別在庫を結合して1商品を取得する。取得時は次の順でモデルへ設定する。

1. `ResultSet`から共通項目、カテゴリ情報、メーカー情報、在庫情報を取得する。
2. 固有モデル（`Foods`、`Av`、`Pc`）へ共通情報を設定する。
3. 固有カラムを各setterで設定する。
4. `setZaikoHyouji()`を呼び出して既存の在庫表示ルールを適用する。
5. 商品が存在しない場合またはSQL例外時は`null`を返す。なお、未登録コード時の空レスポンスは既存仕様上の課題として別管理する。

### 3.3 既存クラスの変更

| クラス | 変更メソッド・項目 | 変更内容 |
|---|---|---|
| `DaoControl` | `selectShohin(String code, String eigyosyoCD)` | 商品コード先頭2桁が`03`なら`DaoFoods`、`04`なら`DaoAv`、`05`なら`DaoPc`へ振り分け |
| `JuchuControl` | `entry(HttpServletRequest, HttpServletResponse)` | 詳細コード`03`、`04`、`05`をそれぞれ`cosd1042.jsp`～`cosd1044.jsp`へ転送 |
| `ShohinCategory` | `setGctgCDFrmGoodsCD(String)` | `substring(0, 2)`でカテゴリコードを抽出 |
| `ShohinCategory` | `setGsubctgCDFrmGoodsCD(String)` | `substring(0, 4)`でサブカテゴリコードを抽出 |
| `DaoConnectionManager` | `URL`定数 | 接続先を`COSCOMMON02`へ変更 |

## 4. JSP・画像詳細設計

| JSP | 受け取るモデル | 表示する固有項目 |
|---|---|---|
| `cosd1042.jsp` | `Foods` | 味、内容量、製造国、熱量、原材料、栄養成分 |
| `cosd1043.jsp` | `Av` | 色、型番、画面サイズ、解像度、出力音量、容量、メディア、インターフェース、消費電力、付属品、保証、質量、寸法 |
| `cosd1044.jsp` | `Pc` | 色、型番、画面サイズ、解像度、CPU、メモリ、HDD、ドライブ、ネットワーク、OS、統合ソフト、バッテリ、付属品、保証、質量、寸法 |

画像はDBの`IMG_URI`を既存画面の画像表示方式で使用し、次のフォルダーへ配置する。

- `juchu02/WebContent/img/foods`
- `juchu02/WebContent/img/av`
- `juchu02/WebContent/img/pc`

## 5. 処理フロー

1. 商品検索画面からサブカテゴリコードを送信する。
2. `DaoControl`が商品コードのカテゴリを判定し、対応DAOを呼び出す。
3. DAOがカテゴリ、サブカテゴリ、メーカー、商品、営業所別在庫を結合して取得する。
4. `Foods`、`Av`、`Pc`のいずれかへ値を設定する。
5. `JuchuControl`がカテゴリ別詳細JSPへ転送する。
6. 詳細画面から既存カート処理へ進み、受注時は既存の明細登録・在庫引当処理を利用する。

## 6. SQL・ソース管理

- `sql/ver.2/create.sql`、`insert.sql`、`select.sql`は直前版SQLをコピーして作成した。
- SQL、Java、JSP、HTMLの変更箇所には、作業内容と`ver.2`の範囲を示す日本語コメントを付与した。
- `juchu01`のソースと`COSCOMMON01`は変更しない。

## 7. テストとの対応

詳細設計に対する確認として、Javaコンパイル、DB件数・在庫照合、63検索、765詳細・画像表示、混在カート、食品受注、在庫不足、文具・書籍回帰を実施した。テスト項目と判定はver.2_テスト報告書を参照する。
