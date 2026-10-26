# バージョン別SQL管理

## 基準SQL

直下の`create.sql`、`insert.sql`、`select.sql`はVer.1の基準SQLである。`juchu01` / `COSCOMMON01`用として保持し、変更しない。

## バージョン別SQL

| バージョン | フォルダー | 対象DB | コピー元 |
|---|---|---|---|
| Ver.2 | `sql/ver.2` | `COSCOMMON02` | Ver.1直下SQL |
| Ver.3 | `sql/ver.3` | `COSCOMMON03` | `sql/ver.2` |
| Ver.4 | `sql/ver.4` | `COSCOMMON04` | `sql/ver.3` |
| Ver.5 | `sql/ver.5` | `COSCOMMON05` | `sql/ver.4` |

各フォルダーには`create.sql`、`insert.sql`、`select.sql`を配置する。実装時は直前バージョンのSQLをコピーしてから、対象バージョンの変更を追加する。

## コメントルール

作業上の注意②に従い、SQLの変更箇所には日本語で次の情報をコメントする。

```sql
-- ***** ここから ver.2
-- 作業内容: 商品カテゴリ・商品・在庫を追加
-- ***** ここまで ver.2
```

バージョン別SQLには、対象DB・コピー元・作業内容を記載済みである。実際のDDL・初期データ追加時は、追加・変更したSQLブロックごとに同じコメントを付ける。
