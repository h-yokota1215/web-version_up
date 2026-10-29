# juchu01 ver.2 開発成果物

ver.2の要求分析、設計、実装、テスト、報告資料をまとめたフォルダーである。

## 開発対象

- 基準プロジェクト：`../juchu01`（Ver.1。変更禁止）
- ver.2開発プロジェクト：`../juchu02`
- ver.2 DB：H2 `COSCOMMON02`
- コンテキスト・ルート：`juchu02`
- SQL：`ver.2/SQL/create.sql`、`insert.sql`、`select.sql`

実装本体はworkspace直下の`juchu02`に配置し、ver.2で使用したSQL・設計書・テスト資料・報告資料を本フォルダーで管理する。

## 完了状況

ver.2は、要求分析、基本設計、詳細設計、UML作成、DB実装、Java実装、画面実装、テスト、報告資料作成まで完了している。

テスト結果の正式対象は43項目で、合格43件、未実施0件である。

## フォルダー構成

```text
ver.2/
├─ README.md
├─ SQL/
│  ├─ create.sql       # COSCOMMON02用DDL
│  ├─ insert.sql       # ver.2初期データ
│  └─ select.sql       # 件数・整合性確認SQL
├─ 設計書/
│  ├─ ver.2_仕様書.docx
│  ├─ ver.2_設計書.docx
│  ├─ ver.2_テスト仕様書.docx
│  ├─ juchu01_ver2要求分析.md
│  ├─ ver.2_基本設計書.md
│  ├─ ver.2_詳細設計書.md
│  ├─ ver.2_テスト仕様追補.md
│  ├─ ver.2_設計レビュー.md
│  ├─ ver.2_設計完了チェックリスト.md
│  ├─ ver.2_変更対象一覧.md
│  ├─ DB設計/
│  │  ├─ ver.2_DB物理設計書.md
│  │  └─ ver.2_DB物理設計書.pdf
│  └─ UML/
│     ├─ ver.2_UML一覧.md
│     ├─ ver.2_要求図.puml
│     ├─ ver.2_ユースケース図.puml
│     ├─ ver.2_クラス図.puml
│     └─ ver.2_商品検索シーケンス図.puml
├─ テスト/
│  └─ ver.2_テスト項目一覧.xlsx
├─ プログラム/
│  ├─ make_ver2_report.py
│  ├─ make_ver2_test_excel.py
│  └─ make_ver2_test_excel.ps1
├─ 報告書/
│  ├─ V2テスト報告書.pptx
│  ├─ ver.2_改修概要.md
│  ├─ ver.2_改修詳細.md
│  ├─ ver.2_改修詳細報告書.docx
│  └─ ver.2_改修詳細報告書.pdf
└─ ver.2_作業・振り返り.md
```

## 設計書

提出用DOCXは、仕様書・設計書・テスト仕様書をそれぞれ次に配置している。

- [仕様書（DOCX）](設計書/ver.2_仕様書.docx)
- [設計書（DOCX）](設計書/ver.2_設計書.docx)
- [テスト仕様書（DOCX）](設計書/ver.2_テスト仕様書.docx)

- [要求分析](設計書/juchu01_ver2要求分析.md)
- [基本設計書](設計書/ver.2_基本設計書.md)
- [詳細設計書](設計書/ver.2_詳細設計書.md)
- [テスト仕様追補](設計書/ver.2_テスト仕様追補.md)
- [設計レビュー](設計書/ver.2_設計レビュー.md)
- [設計完了チェックリスト](設計書/ver.2_設計完了チェックリスト.md)
- [変更対象一覧](設計書/ver.2_変更対象一覧.md)
- [DB物理設計書](設計書/DB設計/ver.2_DB物理設計書.md)
- [UML一覧](設計書/UML/ver.2_UML一覧.md)

## SQL

`SQL`フォルダーのSQLは、`COSCOMMON02`に対するver.2の実行用である。

| ファイル | 内容 |
|---|---|
| [create.sql](SQL/create.sql) | 直前版を基にしたテーブル定義・ver.2追加DDL |
| [insert.sql](SQL/insert.sql) | カテゴリ、商品、在庫などの初期データ |
| [select.sql](SQL/select.sql) | 件数、コード、在庫、画像URIの確認SQL |

## 実装プロジェクト

実装対象はworkspace直下の[`juchu02`](../juchu02)である。主な追加・変更対象は次のとおり。

- Javaモデル：`Foods`、`Av`、`Pc`
- Java DAO：`DaoFoods`、`DaoAv`、`DaoPc`
- 制御処理：`DaoControl`、`JuchuControl`、`ShohinCategory`
- 詳細画面：`cosd1042.jsp`、`cosd1043.jsp`、`cosd1044.jsp`
- 画像：`juchu02/WebContent/img/foods`、`av`、`pc`

## テスト・報告資料

- [テスト項目一覧](テスト/ver.2_テスト項目一覧.xlsx)
- [V2テスト報告書（PowerPoint）](報告書/V2テスト報告書.pptx)
- [改修概要](報告書/ver.2_改修概要.md)
- [改修詳細（Markdown）](報告書/ver.2_改修詳細.md)
- [改修詳細報告書（Word）](報告書/ver.2_改修詳細報告書.docx)
- [改修詳細報告書（PDF）](報告書/ver.2_改修詳細報告書.pdf)
- [作業・振り返り](ver.2_作業・振り返り.md)

テスト結果の詳細は`設計書/ver.2_テスト仕様追補.md`に記録し、基準版から引き継いだ未登録コード空レスポンスはworkspace直下の`juchu01_既存不具合報告_未登録コード空レスポンス.md`で別管理する。

## 後続バージョン

後続バージョンは、直前バージョンをコピーして新しいプロジェクトフォルダーとH2データベースを作成する。過去バージョンは変更しない。

| バージョン | プロジェクト | DB |
|---|---|---|
| ver.3 | `../juchu03` | `COSCOMMON03` |
| ver.4 | `../juchu04` | `COSCOMMON04` |
| ver.5 | `../juchu05` | `COSCOMMON05` |

## 作業記録の更新ルール

1. 設計変更は`設計書`の該当資料とUMLへ反映する。
2. SQL変更は`SQL`配下へ反映する。
3. 実装結果・問題・判断は`ver.2_作業・振り返り.md`へ記録する。
4. テスト結果は`設計書/ver.2_テスト仕様追補.md`へ反映する。
5. 成果物の移動・追加時は、このREADMEの構成図とリンクを更新する。
