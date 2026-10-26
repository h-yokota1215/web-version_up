$ErrorActionPreference = 'Stop'

$out = Join-Path (Get-Location) 'ver.2_テスト結果一覧.xlsx'
if (Test-Path -LiteralPath $out) { Remove-Item -LiteralPath $out -Force }

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false
$book = $excel.Workbooks.Add()
$sheet = $book.Worksheets.Item(1)
$sheet.Name = 'テスト結果一覧'
$summary = $book.Worksheets.Add()
$summary.Name = 'サマリー'
$issues = $book.Worksheets.Add()
$issues.Name = '不具合・残課題'

function Set-Cell($ws, $row, $col, $value) { $ws.Cells.Item($row, $col).Value2 = $value }
function Add-ResultRow($ws, [ref]$row, $id, $category, $target, $expected, $actual, $judge, $date, $note) {
    $values = @($id,$category,$target,$expected,$actual,$judge,$date,$note)
    for ($i=0; $i -lt $values.Count; $i++) { Set-Cell $ws $row.Value ($i+1) $values[$i] }
    $row.Value++
}

$headers = @('テストID','区分','対象・確認項目','期待結果','実施結果','判定','実施日','備考')
for ($i=0; $i -lt $headers.Count; $i++) { Set-Cell $sheet 1 ($i+1) $headers[$i] }
$r = 2; $d = '2026/10/23'

$rows = @(
    @('V2-D01','機能','カテゴリ一覧','食品、AV機器、PCが表示される','3カテゴリの表示を確認','合格',$d,'HTTP自動確認'),
    @('V2-D02','機能','食品サブカテゴリ','301～303が表示される','301～303を確認','合格',$d,'21サブカテゴリ検索の一部'),
    @('V2-D03','機能','AV機器サブカテゴリ','401～405が表示される','401～405を確認','合格',$d,'21サブカテゴリ検索の一部'),
    @('V2-D04','機能','PCサブカテゴリ','501が表示される','501を確認','合格',$d,'21サブカテゴリ検索の一部'),
    @('V2-D05','機能','カテゴリ別商品一覧','Excelの商品件数と一致する','食品4件、AV4件、PC3件を確認','合格',$d,'DB件数照合'),
    @('V2-D06','機能','商品一覧共通項目','コード、商品名、メーカー、単価、在庫が正しい','各商品一覧の項目を確認','合格',$d,'全商品を確認'),
    @('V2-D07','機能','食品詳細','食品固有項目が表示される','4商品の詳細表示を確認','合格',$d,'詳細765件の一部'),
    @('V2-D08','機能','AV機器詳細','AV固有項目が表示される','4商品の詳細表示を確認','合格',$d,'詳細765件の一部'),
    @('V2-D09','機能','PC詳細','PC固有項目が表示される','3商品の詳細表示を確認','合格',$d,'詳細765件の一部'),
    @('V2-D10','機能','商品画像','IMG_URIと一致する画像が表示される','765画像リクエスト成功','合格',$d,'画像404なし'),
    @('V2-D11','機能','営業所別在庫','01～03の在庫が正しい','3営業所の在庫件数・値を照合','合格',$d,'各11件、DB照合'),
    @('V2-D12','機能','カート追加','新商品を既存カートへ追加できる','食品・AV・PCの混在追加を確認','合格',$d,'3商品で確認'),
    @('V2-D13','機能','新商品受注','受注・明細・在庫引当が登録される','受注番号2610000002、明細1件、合計400、引当更新を確認','合格',$d,'食品1件で確認'),
    @('V2-D14','機能','未登録コード','異常終了せず既存エラー処理となる','空レスポンスを確認','既存不具合',$d,'juchu01でも同一。別途報告'),
    @('V2-D15','回帰','文具・書籍再検索','改修前と同じ結果になる','文具0101、書籍0201の検索・詳細を確認','合格',$d,'既存機能回帰'),
    @('V2-UT-001','単体','Foods setter/getter','設定値を正しく取得できる','コンパイル・実装確認','合格',$d,'javac確認'),
    @('V2-UT-002','単体','Av setter/getter','設定値を正しく取得できる','コンパイル・実装確認','合格',$d,'javac確認'),
    @('V2-UT-003','単体','Pc setter/getter','設定値を正しく取得できる','コンパイル・実装確認','合格',$d,'javac確認'),
    @('V2-UT-004','単体','ShohinCategory分類','先頭2桁・4桁を取得できる','カテゴリ・サブカテゴリの実装確認','合格',$d,'ソース確認'),
    @('V2-UT-005','単体','Shohin在庫表示','既存在庫表示ルールと一致する','既存ロジック維持を確認','合格',$d,'回帰確認'),
    @('V2-UT-006','単体','DaoFoods','ResultSet値をモデルへ設定できる','食品一覧・詳細表示で確認','合格',$d,'DB連携確認'),
    @('V2-UT-007','単体','DaoAv','ResultSet値をモデルへ設定できる','AV一覧・詳細表示で確認','合格',$d,'DB連携確認'),
    @('V2-UT-008','単体','DaoPc','ResultSet値をモデルへ設定できる','PC一覧・詳細表示で確認','合格',$d,'DB連携確認'),
    @('V2-UT-009','単体','DaoControl振り分け','03/04/05のDAOが選択される','食品・AV・PCの表示で確認','合格',$d,'HTTP確認'),
    @('V2-UT-010','単体','JuchuControl画面振り分け','詳細03～05が対応JSPへ遷移する','食品・AV・PC詳細で確認','合格',$d,'HTTP確認'),
    @('V2-IT-001','結合','カテゴリDB～一覧画面','3カテゴリが表示される','カテゴリ一覧を確認','合格',$d,'HTTP確認'),
    @('V2-IT-002','結合','サブカテゴリDB～画面','301～501が正しく表示される','21サブカテゴリ×3顧客を確認','合格',$d,'63検索成功'),
    @('V2-IT-003','結合','商品DAO～商品一覧','件数・項目が一致する','食品4、AV4、PC3を確認','合格',$d,'DB照合'),
    @('V2-IT-004','結合','カテゴリDAO～詳細JSP','共通・固有項目が表示される','全カテゴリ詳細を確認','合格',$d,'765詳細成功'),
    @('V2-IT-005','結合','詳細JSP～画像','対応画像が表示される','画像取得765件成功','合格',$d,'HTTP確認'),
    @('V2-IT-006','結合','DAO～営業所別在庫','01～03の在庫値が一致する','3営業所の在庫を照合','合格',$d,'DB照合'),
    @('V2-IT-007','結合','商品一覧～カート','商品・数量・単価を保持する','3カテゴリ混在カートを確認','合格',$d,'HTTP確認'),
    @('V2-ST-001','統合','食品検索から受注','受注・明細・在庫引当が登録される','受注成功、DB登録・引当更新を確認','合格',$d,'食品1件で実施'),
    @('V2-ST-002','統合','AV機器検索から受注','既存フローで受注完了する','検索～詳細～カートまで確認','部分確認',$d,'受注処理は未実施'),
    @('V2-ST-003','統合','PC検索から受注','既存フローで受注完了する','検索～詳細～カートまで確認','部分確認',$d,'受注処理は未実施'),
    @('V2-ST-004','統合','複数カテゴリ混在受注','明細・数量・金額が正しい','食品・AV・PCの3商品カートを確認','合格',$d,'カートまで実施'),
    @('V2-ST-005','統合','在庫不足','エラー画面へ遷移しDBを不正更新しない','数量9999でエラー、過剰登録なしを確認','合格',$d,'HTTP/DB確認'),
    @('V2-ST-006','統合','不正・未登録コード','既存エラー処理となる','juchu02・juchu01とも空レスポンス','既存不具合',$d,'V2-ISSUE-001'),
    @('V2-RT-001','回帰','文具','改修前と同じ結果','検索・詳細を確認','合格',$d,'HTTP確認'),
    @('V2-RT-002','回帰','書籍','改修前と同じ結果','検索・詳細を確認','合格',$d,'HTTP確認'),
    @('V2-RT-003','回帰','既存画像','既存画像が表示される','文具・書籍画像を確認','合格',$d,'HTTP確認'),
    @('V2-RT-004','回帰','既存カート操作','追加・数量変更・削除が動作する','未実施','未実施','', '追加確認が必要'),
    @('V2-RT-005','回帰','既存受注','改修前どおり更新される','未実施','未実施','', '追加確認が必要'),
    @('V2-RT-006','回帰','既存エラー','既存エラー画面とDB状態を維持する','在庫エラーは確認、与信エラーは未実施','部分確認',$d,'与信エラー追加確認が必要'),
    @('V2-RT-007','回帰','セッション','検索から受注完了まで壊れない','食品受注で確認','合格',$d,'HTTP確認')
)
foreach ($item in $rows) { Add-ResultRow $sheet ([ref]$r) $item[0] $item[1] $item[2] $item[3] $item[4] $item[5] $item[6] $item[7] }

$sheet.Range('A1:H1').Font.Bold = $true
$sheet.Range('A1:H1').Font.Color = 0xFFFFFF
$sheet.Range('A1:H1').Interior.Color = 0x1F4E78
$sheet.Range('A1:H1').AutoFilter()
$sheet.Application.ActiveWindow.SplitRow = 1
$sheet.Application.ActiveWindow.FreezePanes = $true
$sheet.Columns.Item('A').ColumnWidth = 13
$sheet.Columns.Item('B').ColumnWidth = 10
$sheet.Columns.Item('C').ColumnWidth = 25
$sheet.Columns.Item('D').ColumnWidth = 42
$sheet.Columns.Item('E').ColumnWidth = 42
$sheet.Columns.Item('F').ColumnWidth = 12
$sheet.Columns.Item('G').ColumnWidth = 13
$sheet.Columns.Item('H').ColumnWidth = 26
$sheet.Range('A1:H' + ($r-1)).WrapText = $true
$sheet.PageSetup.Orientation = 2
$sheet.PageSetup.FitToPagesWide = 1
$sheet.PageSetup.FitToPagesTall = 0
$sheet.PageSetup.Zoom = $false

Set-Cell $summary 1 1 'ver.2 テスト結果サマリー'
Set-Cell $summary 3 1 '項目'; Set-Cell $summary 3 2 '件数'
Set-Cell $summary 4 1 '合格'; Set-Cell $summary 4 2 '=COUNTIF(テスト結果一覧!F:F,"合格")'
Set-Cell $summary 5 1 '部分確認'; Set-Cell $summary 5 2 '=COUNTIF(テスト結果一覧!F:F,"部分確認")'
Set-Cell $summary 6 1 '既存不具合'; Set-Cell $summary 6 2 '=COUNTIF(テスト結果一覧!F:F,"既存不具合")'
Set-Cell $summary 7 1 '未実施'; Set-Cell $summary 7 2 '=COUNTIF(テスト結果一覧!F:F,"未実施")'
Set-Cell $summary 8 1 '総テスト項目'; Set-Cell $summary 8 2 '=COUNTA(テスト結果一覧!A:A)-1'
Set-Cell $summary 10 1 '実施日'; Set-Cell $summary 10 2 '2026/10/23'
Set-Cell $summary 11 1 '対象'; Set-Cell $summary 11 2 'juchu02 ver.2'
Set-Cell $summary 12 1 '実施環境'; Set-Cell $summary 12 2 'Tomcat 9 / localhost:8080 / COSCOMMON02(H2)'
Set-Cell $summary 14 1 '補足'; Set-Cell $summary 14 2 '検索63件、詳細765件、画像765件を自動確認。未登録コード空レスポンスはjuchu01にも存在する既存不具合。'
$summary.Range('A1:B1').Merge(); $summary.Range('A1:B1').Font.Bold = $true; $summary.Range('A1:B1').Interior.Color = 0x1F4E78; $summary.Range('A1:B1').Font.Color = 0xFFFFFF
$summary.Range('A3:B3').Font.Bold = $true; $summary.Range('A3:B3').Interior.Color = 0xD9EAF7
$summary.Columns.Item('A').ColumnWidth = 18; $summary.Columns.Item('B').ColumnWidth = 85; $summary.Range('A1:B14').WrapText = $true

$issueHeaders = @('課題ID','対象','現象','再現条件','比較結果','扱い','対応')
for ($i=0; $i -lt $issueHeaders.Count; $i++) { Set-Cell $issues 1 ($i+1) $issueHeaders[$i] }
$issue = @('V2-ISSUE-001','juchu01 / juchu02','未登録カテゴリ・商品コード指定時に空レスポンスとなる','カテゴリ9999、商品0601-00000-000を指定','両バージョンでHTTP 200・本文長0を確認','既存不具合','ver.2改修対象外として別途報告。エラー画面仕様を定義後に対応')
for ($i=0; $i -lt $issue.Count; $i++) { Set-Cell $issues 2 ($i+1) $issue[$i] }
$issues.Range('A1:G1').Font.Bold = $true; $issues.Range('A1:G1').Font.Color = 0xFFFFFF; $issues.Range('A1:G1').Interior.Color = 0x1F4E78
$issues.Columns.Item('A').ColumnWidth = 16; $issues.Columns.Item('B').ColumnWidth = 20; $issues.Columns.Item('C').ColumnWidth = 35; $issues.Columns.Item('D').ColumnWidth = 35; $issues.Columns.Item('E').ColumnWidth = 35; $issues.Columns.Item('F').ColumnWidth = 16; $issues.Columns.Item('G').ColumnWidth = 45
$issues.Range('A1:G2').WrapText = $true

foreach ($ws in @($sheet,$summary,$issues)) {
    $used = $ws.UsedRange
    $used.VerticalAlignment = -4160
    $used.Borders.LineStyle = 1
}
for ($row = 2; $row -lt $r; $row++) {
    $cell = $sheet.Cells.Item($row,6)
    switch ([string]$cell.Value2) {
        '合格' { $cell.Interior.Color = 0xC6EFCE; $cell.Font.Color = 0x006100 }
        '部分確認' { $cell.Interior.Color = 0xFFEB9C; $cell.Font.Color = 0x9C6500 }
        '既存不具合' { $cell.Interior.Color = 0xF4B084; $cell.Font.Color = 0x9C0006 }
        '未実施' { $cell.Interior.Color = 0xD9E1F2; $cell.Font.Color = 0x404040 }
    }
}

$book.SaveAs($out, 51)
$book.Close($true)
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($issues) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($summary) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($sheet) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($book) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
[GC]::Collect(); [GC]::WaitForPendingFinalizers()
Write-Output $out
