# juchu01 現行プログラム説明

## 1. システム概要

`juchu01` は、法人顧客向けの商品検索・カート・受注登録・顧客登録を行うJava Webアプリケーションである。

| 項目 | 内容 |
|---|---|
| 開発形式 | Eclipse Dynamic Web Project |
| 言語 | Java、JSP、JavaScript、CSS |
| 実行環境 | Java 11、Tomcat 9 |
| Web入口 | `CosServlet` |
| データベース | H2 Database |
| DB接続先 | `jdbc:h2:tcp://localhost/~/coscommon01` |
| 画面遷移 | ServletからControlを呼び出し、JSPへforward |

## 2. ディレクトリ構成

```text
juchu01/
├─ src/
│  ├─ cos/                 制御・Servlet層
│  ├─ cosDAO/              DBアクセス層
│  └─ cosDataPack/         データモデル層
├─ WebContent/
│  ├─ cosd1000.html        トップ・ログイン画面
│  ├─ cosd1010.jsp～1110.jsp 受注・顧客登録画面
│  ├─ cosd150E.jsp～155E.jsp エラー画面
│  ├─ css/                  スタイルシート
│  ├─ js/                   共通JavaScript
│  └─ WEB-INF/web.xml      Servlet設定
```

## 3. 全体処理フロー

```text
ブラウザ
  ↓ POST /CosServlet
CosServlet
  ↓
CosControl.action()
  ↓ ボタン名（top / order / user）を判定
  ├─ NinshouControl       ログイン・ログオフ
  ├─ KokyakuControl       顧客登録
  └─ JuchuControl          商品検索・カート・受注
       ↓
    DaoControl → 各DAO → H2 Database
       ↓
    対応するJSPへforward
```

## 4. リクエスト処理

### 4.1 CosServlet

`CosServlet` はWebリクエストを受け付けるServletである。

- `init()`で`CosControl`を生成する。

- `doPost()`で文字コードをUTF-8に設定し、`CosControl.action()`を呼び出す。

- `doDelete()`でDAOのDB接続を終了する。

### 4.2 CosControl

`CosControl`はリクエストの入口となる振り分け処理を担当する。

- `top` パラメータがある場合はログオフ処理を実行する。

- `order` パラメータがある場合はログインまたは受注処理を実行する。

- `user` パラメータがある場合は顧客登録処理を実行する。

- ログイン後は`JuchuControl`を生成し、セッションに保存する。

- 顧客登録中は`KokyakuControl`を生成し、セッションに保存する。

## 5. Javaクラスの役割

### 5.1 `cos` パッケージ

| ファイル | 役割 |
|---|---|
| `BaseControl.java` | Controlクラスの基底クラス。DAO、ボタンとJSPのマップ、コマンド、セッションを保持する。 |
| `CosServlet.java` | 全POSTリクエストを受け付け、`CosControl`へ処理を委譲する。 |
| `CosControl.java` | リクエストをログイン・顧客登録・受注処理へ振り分ける。 |
| `NinshouControl.java` | 顧客コードとパスワードによるログイン、ログインエラー、ログオフを処理する。 |
| `KokyakuControl.java` | 顧客登録画面の初期化、入力取得、顧客登録、登録エラーを処理する。 |
| `JuchuControl.java` | 商品検索、商品詳細、カート、支払・配送情報、受注確定を処理する。 |
| `ShohinControl.java` | 商品カテゴリ一覧と商品一覧の取得を行う。 |

### 5.2 `cosDAO` パッケージ

| ファイル | 役割 |
|---|---|
| `DaoConnectionManager.java` | H2データベースへの接続を生成する接続管理クラス。 |
| `DaoControl.java` | 顧客・商品・受注DAOをまとめて呼び出すDAO統括クラス。 |
| `DaoKokyaku.java` | 顧客共通処理、顧客コード・営業所コード取得、認証、番号分割を行う抽象DAO。 |
| `DaoHoujin.java` | 法人顧客の登録・検索処理を行う。 |
| `DaoShohin.java` | 商品カテゴリ取得、商品一覧取得、カテゴリに応じた処理を行う。 |
| `DaoBungu.java` | 文具商品の検索・詳細取得を行う派生DAO。 |
| `DaoBook.java` | 書籍商品の検索・詳細取得を行う派生DAO。 |
| `DaoJuchu.java` | 受注登録、明細登録、在庫引当、売掛残高更新、受注番号採番を行う。 |

### 5.3 `cosDataPack` パッケージ

| ファイル | 役割 |
|---|---|
| `Kokyaku.java` | 顧客共通情報を保持するデータクラス。 |
| `Houjin.java` | 業種、担当者名、担当部署など法人固有情報を保持する。 |
| `Juchu.java` | 顧客、明細、支払方法、納品予定、合計金額、エラー情報を保持する。 |
| `Meisai.java` | 商品、数量、金額、明細番号、納品情報を保持する。 |
| `Shohin.java` | 商品コード、名称、単価、カテゴリ、在庫、メーカーなどを保持する。 |
| `ShohinPrimalData.java` | 受注明細作成時に使う商品の基本情報を保持する。 |
| `ShohinCategory.java` | 商品カテゴリ・サブカテゴリ情報を保持する。 |
| `Bungu.java` | 文具固有の商品情報を保持する。 |
| `Book.java` | ISBN、著者、ページ数など書籍固有情報を保持する。 |

## 6. JSP・HTML画面の役割

| ファイル | 画面・役割 |
|---|---|
| `cosd1000.html` | トップページ。ログインと新規顧客登録の入口。 |
| `cosd1010.jsp` | ログイン後の商品カテゴリ選択・商品検索画面。 |
| `cosd1020.jsp` | カテゴリ別商品一覧。数量入力、詳細表示、カート追加を行う。 |
| `cosd1030.jsp` | カート内容・受注明細一覧。数量変更、再計算、注文手続きを行う。 |
| `cosd1040.jsp` | 文具商品の詳細画面。 |
| `cosd1041.jsp` | 書籍商品の詳細画面。 |
| `cosd1050.jsp` | 注文内容確認画面。 |
| `cosd1060.jsp` | 支払方法・納品予定日・納品時間帯の入力画面。 |
| `cosd1070.jsp` | 注文最終確認画面。 |
| `cosd1080.jsp` | 注文完了画面。 |
| `cosd1090.jsp` | 顧客登録情報の入力画面。 |
| `cosd1100.jsp` | 顧客登録情報の確認画面。 |
| `cosd1110.jsp` | 顧客登録完了画面。 |
| `cosd150E.jsp` | ログインエラー画面。 |
| `cosd151E.jsp` | 在庫引当エラー画面。 |
| `cosd152E.jsp` | 与信限度額エラー画面。 |
| `cosd153E.jsp` | 顧客登録エラー画面。 |
| `cosd155E.jsp` | システムエラー画面。 |

## 7. 画面遷移

### ログインから受注完了まで

```text
cosd1000.html
  → cosd1010.jsp 商品検索
  → cosd1020.jsp 商品一覧
  → cosd1040.jsp / cosd1041.jsp 商品詳細
  → cosd1030.jsp カート
  → cosd1050.jsp 注文確認
  → cosd1060.jsp 支払・納品入力
  → cosd1070.jsp 最終確認
  → cosd1080.jsp 注文完了
```

### 顧客登録

```text
cosd1000.html
  → cosd1090.jsp 顧客情報入力
  → cosd1100.jsp 顧客情報確認
  → cosd1110.jsp 登録完了
```

## 8. DAOと主なDB処理

現在のDAOは、主に以下のテーブルを利用する。

- `CTR_CURCODE_TABLE`：顧客番号・受注番号などの現在値を管理する。

- `GSUBCTG_TABLE`、`CTR_GCTG_TABLE`：商品カテゴリを管理する。

- `BUNGU_TABLE`、`BOOK_TABLE`：文具・書籍の商品情報を管理する。

- `HANBAIZAIKO*_TABLE`：営業所別の在庫・引当数を管理する。

- `KOKYAKUHOUJIN_TABLE`：法人顧客情報を管理する。

- `KOKYAKUPASS_TABLE`：顧客コードとパスワードを管理する。

- `JUCHU_TABLE`：受注情報を管理する。

- `JUCHUMEISAI_TABLE`：受注明細を管理する。

受注確定時は、顧客売掛残高更新、受注番号更新、受注登録、在庫引当数更新、受注明細登録をトランザクション内で実行し、成功時にcommit、失敗時にrollbackする構造になっている。

## 9. セッションに保持される主な情報

| 属性名 | 内容 |
|---|---|
| `juchucontrol` | ログイン後の`JuchuControl`。受注・カート状態を保持する。 |
| `kokyakucontrol` | 顧客登録中の`KokyakuControl`。入力中の顧客情報を保持する。 |
| `subctgcd` | 商品検索に使用するサブカテゴリコード。 |
| `shohin` | 商品詳細表示対象の商品。 |

## 10. 現行プログラム上の改修関連ポイント

- ver.2：`Shohin`、商品固有クラス、`DaoShohin`、新カテゴリ用DAO、商品一覧・詳細JSP。

- ver.3：`Kokyaku`、個人顧客クラス、`DaoKokyaku`系、`KokyakuControl`、支払方法画面。

- ver.4：`Juchu`、`Meisai`、受注金額計算、注文確認JSP、`DaoJuchu`。

- ver.5：`DaoKokyaku`を中心とした認証SQL、およびSQL文字列を直接生成しているDAO。

## 11. 現行実装上の注意点

- DAOではSQLを文字列連結で組み立てている箇所がある。

- ログイン処理では顧客コードとパスワードをSQL条件に直接連結している。

- パスワードは現在、`KOKYAKUPASS_TABLE`で平文として扱われている。

- `CosControl`のDAOはstaticフィールドで管理されている。

- `CosServlet.doPost()`は例外をcatchしてスタックトレース出力する方式である。

- JSPにJavaスクリプトレットが多く、画面表示と処理ロジックが混在している。

- `web.xml`のwelcome file設定と、実際の入口ファイル`cosd1000.html`が一致していない。

## 12. 参照ファイル

- [juchu01改修計画](./juchu01_改修計画.md)

- [WBS](./WBS_juchu01_ver2-ver5.puml)

- [web.xml](./juchu01/WebContent/WEB-INF/web.xml)

- [CosServlet.java](./juchu01/src/cos/CosServlet.java)

- [CosControl.java](./juchu01/src/cos/CosControl.java)

- [JuchuControl.java](./juchu01/src/cos/JuchuControl.java)
