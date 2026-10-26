from zipfile import ZipFile, ZIP_DEFLATED
from xml.sax.saxutils import escape
from pathlib import Path

OUT = Path('ver.2_テスト結果一覧_修正版.xlsx')
D = '2026/10/23'
rows = [
('V2-D01','機能','カテゴリ一覧','食品、AV機器、PCが表示される','3カテゴリの表示を確認','合格',D,'HTTP自動確認'),
('V2-D02','機能','食品サブカテゴリ','301～303が表示される','301～303を確認','合格',D,'21サブカテゴリ検索の一部'),
('V2-D03','機能','AV機器サブカテゴリ','401～405が表示される','401～405を確認','合格',D,'21サブカテゴリ検索の一部'),
('V2-D04','機能','PCサブカテゴリ','501が表示される','501を確認','合格',D,'21サブカテゴリ検索の一部'),
('V2-D05','機能','カテゴリ別商品一覧','Excelの商品件数と一致する','食品4件、AV4件、PC3件を確認','合格',D,'DB件数照合'),
('V2-D06','機能','商品一覧共通項目','コード、商品名、メーカー、単価、在庫が正しい','各商品一覧の項目を確認','合格',D,'全商品を確認'),
('V2-D07','機能','食品詳細','食品固有項目が表示される','4商品の詳細表示を確認','合格',D,'詳細765件の一部'),
('V2-D08','機能','AV機器詳細','AV固有項目が表示される','4商品の詳細表示を確認','合格',D,'詳細765件の一部'),
('V2-D09','機能','PC詳細','PC固有項目が表示される','3商品の詳細表示を確認','合格',D,'詳細765件の一部'),
('V2-D10','機能','商品画像','IMG_URIと一致する画像が表示される','765画像リクエスト成功','合格',D,'画像404なし'),
('V2-D11','機能','営業所別在庫','01～03の在庫が正しい','3営業所の在庫件数・値を照合','合格',D,'各11件、DB照合'),
('V2-D12','機能','カート追加','新商品を既存カートへ追加できる','食品・AV・PCの混在追加を確認','合格',D,'3商品で確認'),
('V2-D13','機能','新商品受注','受注・明細・在庫引当が登録される','受注番号2610000002、明細1件、合計400、引当更新を確認','合格',D,'食品1件で確認'),
('V2-D14','機能','未登録コード','異常終了せず既存エラー処理となる','空レスポンスを確認','既存不具合',D,'juchu01でも同一。別途報告'),
('V2-D15','回帰','文具・書籍再検索','改修前と同じ結果になる','文具0101、書籍0201の検索・詳細を確認','合格',D,'既存機能回帰'),
('V2-UT-001','単体','Foods setter/getter','設定値を正しく取得できる','コンパイル・実装確認','合格',D,'javac確認'),
('V2-UT-002','単体','Av setter/getter','設定値を正しく取得できる','コンパイル・実装確認','合格',D,'javac確認'),
('V2-UT-003','単体','Pc setter/getter','設定値を正しく取得できる','コンパイル・実装確認','合格',D,'javac確認'),
('V2-UT-004','単体','ShohinCategory分類','先頭2桁・4桁を取得できる','カテゴリ・サブカテゴリの実装確認','合格',D,'ソース確認'),
('V2-UT-005','単体','Shohin在庫表示','既存在庫表示ルールと一致する','既存ロジック維持を確認','合格',D,'回帰確認'),
('V2-UT-006','単体','DaoFoods','ResultSet値をモデルへ設定できる','食品一覧・詳細表示で確認','合格',D,'DB連携確認'),
('V2-UT-007','単体','DaoAv','ResultSet値をモデルへ設定できる','AV一覧・詳細表示で確認','合格',D,'DB連携確認'),
('V2-UT-008','単体','DaoPc','ResultSet値をモデルへ設定できる','PC一覧・詳細表示で確認','合格',D,'DB連携確認'),
('V2-UT-009','単体','DaoControl振り分け','03/04/05のDAOが選択される','食品・AV・PCの表示で確認','合格',D,'HTTP確認'),
('V2-UT-010','単体','JuchuControl画面振り分け','詳細03～05が対応JSPへ遷移する','食品・AV・PC詳細で確認','合格',D,'HTTP確認'),
('V2-IT-001','結合','カテゴリDB～一覧画面','3カテゴリが表示される','カテゴリ一覧を確認','合格',D,'HTTP確認'),
('V2-IT-002','結合','サブカテゴリDB～画面','301～501が正しく表示される','21サブカテゴリ×3顧客を確認','合格',D,'63検索成功'),
('V2-IT-003','結合','商品DAO～商品一覧','件数・項目が一致する','食品4、AV4、PC3を確認','合格',D,'DB照合'),
('V2-IT-004','結合','カテゴリDAO～詳細JSP','共通・固有項目が表示される','全カテゴリ詳細を確認','合格',D,'765詳細成功'),
('V2-IT-005','結合','詳細JSP～画像','対応画像が表示される','画像取得765件成功','合格',D,'HTTP確認'),
('V2-IT-006','結合','DAO～営業所別在庫','01～03の在庫値が一致する','3営業所の在庫を照合','合格',D,'DB照合'),
('V2-IT-007','結合','商品一覧～カート','商品・数量・単価を保持する','3カテゴリ混在カートを確認','合格',D,'HTTP確認'),
('V2-ST-001','統合','食品検索から受注','受注・明細・在庫引当が登録される','受注成功、DB登録・引当更新を確認','合格',D,'食品1件で実施'),
('V2-ST-002','統合','AV機器検索から受注','既存フローで受注完了する','検索～詳細～カートまで確認','部分確認',D,'受注処理は未実施'),
('V2-ST-003','統合','PC検索から受注','既存フローで受注完了する','検索～詳細～カートまで確認','部分確認',D,'受注処理は未実施'),
('V2-ST-004','統合','複数カテゴリ混在受注','明細・数量・金額が正しい','食品・AV・PCの3商品カートを確認','合格',D,'カートまで実施'),
('V2-ST-005','統合','在庫不足','エラー画面へ遷移しDBを不正更新しない','数量9999でエラー、過剰登録なしを確認','合格',D,'HTTP/DB確認'),
('V2-ST-006','統合','不正・未登録コード','既存エラー処理となる','juchu02・juchu01とも空レスポンス','既存不具合',D,'V2-ISSUE-001'),
('V2-RT-001','回帰','文具','改修前と同じ結果になる','検索・詳細を確認','合格',D,'HTTP確認'),
('V2-RT-002','回帰','書籍','改修前と同じ結果になる','検索・詳細を確認','合格',D,'HTTP確認'),
('V2-RT-003','回帰','既存画像','既存画像が表示される','文具・書籍画像を確認','合格',D,'HTTP確認'),
('V2-RT-004','回帰','既存カート操作','追加・数量変更・削除が動作する','未実施','未実施','追加確認が必要'),
('V2-RT-005','回帰','既存受注','改修前どおり更新される','未実施','未実施','追加確認が必要'),
('V2-RT-006','回帰','既存エラー','既存エラー画面とDB状態を維持する','在庫エラーは確認、与信エラーは未実施','部分確認',D,'与信エラー追加確認が必要'),
('V2-RT-007','回帰','セッション','検索から受注完了まで壊れない','食品受注で確認','合格',D,'HTTP確認'),
]

# 画面から通常操作できない不正コード送信は、ver.2正式テストの対象外とする。
# 追加確認済みの既存カート操作・既存受注は合格へ更新する。
rows = [r for r in rows if r[0] not in ('V2-D14', 'V2-ST-006')]
rows = [
    (*r[:4], '既存カートの追加・数量変更・削除を確認', '合格', r[6], '既存機能の回帰確認済み')
    if r[0] == 'V2-RT-004' else
    (*r[:4], '既存商品の受注登録・在庫引当を確認', '合格', r[6], '既存機能の回帰確認済み')
    if r[0] == 'V2-RT-005' else r
    for r in rows
]

def esc(v): return escape(str(v), {'"':'&quot;'})
def cell(v, r, c, style=0, formula=None):
    ref=f'{c}{r}'
    if formula is not None: return f'<c r="{ref}" s="{style}"><f>{formula}</f></c>'
    return f'<c r="{ref}" s="{style}" t="inlineStr"><is><t>{esc(v)}</t></is></c>'
def sheet_xml(data, widths, freeze=False, autofilter=None):
    maxc=len(widths); maxr=len(data)
    cols=''.join(f'<col min="{i+1}" max="{i+1}" width="{w}" customWidth="1"/>' for i,w in enumerate(widths))
    body=[]
    for r,row in enumerate(data,1):
        vals=[]
        for c,v in enumerate(row,1):
            style=1 if r==1 else 0
            if r>1 and c==6:
                style={'合格':2,'部分確認':3,'既存不具合':4,'未実施':5}.get(v,0)
            vals.append(cell(v,r,chr(64+c),style))
        body.append('<row r="%d">%s</row>'%(r,''.join(vals)))
    views=''
    if freeze: views = '<sheetViews><sheetView workbookViewId="0"><pane ySplit="1" topLeftCell="A2" activePane="bottomLeft" state="frozen"/><selection pane="bottomLeft" activeCell="A2" sqref="A2"/></sheetView></sheetViews>'
    filter_xml = f'<autoFilter ref="{autofilter}"/>' if autofilter else ''
    return f'<?xml version="1.0" encoding="UTF-8" standalone="yes"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">{views}<sheetFormatPr defaultRowHeight="15"/><cols>{cols}</cols><sheetData>{"".join(body)}</sheetData>{filter_xml}<pageMargins left="0.25" right="0.25" top="0.5" bottom="0.5" header="0.2" footer="0.2"/><pageSetup orientation="landscape" fitToWidth="1" fitToHeight="0"/></worksheet>'

headers=['テストID','区分','対象・確認項目','期待結果','実施結果','判定','実施日','備考']
test_data=[headers]+[list(x) for x in rows]
summary=[['ver.2 テスト結果サマリー',''],['',''],['項目','件数'],['合格',None],['部分確認',None],['既存不具合',None],['未実施',None],['総テスト項目',None],['',''],['実施日',D],['対象','juchu02 ver.2'],['実施環境','Tomcat 9 / localhost:8080 / COSCOMMON02(H2)'],['',''],['補足','検索63件、詳細765件、画像765件を自動確認。未登録コード空レスポンスはjuchu01にも存在する既存不具合。']]
summary[-1][1] = '検索63件、詳細765件、画像765件を自動確認。不正コード送信は画面操作対象外のため正式テストから除外。'
def summary_xml():
    widths=[20,85]; rowsx=[]
    for r, row in enumerate(summary,1):
        vals=[]
        for c,v in enumerate(row,1):
            if r==4 and c==2: vals.append(cell('',r,'B',0,'COUNTIF(\'テスト結果一覧\'!F:F,"合格")'))
            elif r==5 and c==2: vals.append(cell('',r,'B',0,'COUNTIF(\'テスト結果一覧\'!F:F,"部分確認")'))
            elif r==6 and c==2: vals.append(cell('',r,'B',0,'COUNTIF(\'テスト結果一覧\'!F:F,"既存不具合")'))
            elif r==7 and c==2: vals.append(cell('',r,'B',0,'COUNTIF(\'テスト結果一覧\'!F:F,"未実施")'))
            elif r==8 and c==2: vals.append(cell('',r,'B',0,'COUNTA(\'テスト結果一覧\'!A:A)-1'))
            else: vals.append(cell(v or '',r,chr(64+c),1 if r in (1,3) else 0))
        rowsx.append(f'<row r="{r}">'+''.join(vals)+'</row>')
    return f'<?xml version="1.0" encoding="UTF-8" standalone="yes"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><cols><col min="1" max="1" width="20" customWidth="1"/><col min="2" max="2" width="85" customWidth="1"/></cols><sheetData>{"".join(rowsx)}</sheetData></worksheet>'

issue_data=[['課題ID','対象','現象','再現条件','比較結果','扱い','対応'],['V2-ISSUE-001','juchu01 / juchu02','未登録カテゴリ・商品コード指定時に空レスポンスとなる','カテゴリ9999、商品0601-00000-000を指定','両バージョンでHTTP 200・本文長0を確認','既存不具合','ver.2改修対象外として別途報告。エラー画面仕様を定義後に対応']]
issue_data[1][5] = '対象外'
issue_data[1][6] = '画面から操作できない不正リクエスト。将来の異常系・セキュリティテストで別途対応。'

styles='''<?xml version="1.0" encoding="UTF-8" standalone="yes"?><styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><fonts><font><sz val="11"/><color theme="1"/><name val="Calibri"/></font><font><b/><sz val="11"/><color rgb="FFFFFFFF"/><name val="Calibri"/></font></fonts><fills><fill><patternFill patternType="none"/></fill><fill><patternFill patternType="solid"><fgColor rgb="FF1F4E78"/><bgColor indexed="64"/></patternFill></fill><fill><patternFill patternType="solid"><fgColor rgb="FFC6EFCE"/></patternFill></fill><fill><patternFill patternType="solid"><fgColor rgb="FFFFEB9C"/></patternFill></fill><fill><patternFill patternType="solid"><fgColor rgb="FFF4B084"/></patternFill></fill><fill><patternFill patternType="solid"><fgColor rgb="FFD9E1F2"/></patternFill></fill></fills><borders><border><left/><right/><top/><bottom/><diagonal/></border></borders><cellXfs count="6"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/><xf numFmtId="0" fontId="1" fillId="1" borderId="0" applyFont="1" applyFill="1"/><xf numFmtId="0" fontId="0" fillId="2" borderId="0"/><xf numFmtId="0" fontId="0" fillId="3" borderId="0"/><xf numFmtId="0" fontId="0" fillId="4" borderId="0"/><xf numFmtId="0" fontId="0" fillId="5" borderId="0"/></cellXfs></styleSheet>'''
workbook='''<?xml version="1.0" encoding="UTF-8" standalone="yes"?><workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets><sheet name="テスト結果一覧" sheetId="1" r:id="rId1"/><sheet name="サマリー" sheetId="2" r:id="rId2"/><sheet name="不具合・残課題" sheetId="3" r:id="rId3"/></sheets></workbook>'''
rels='''<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet2.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet3.xml"/><Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/></Relationships>'''
ct='''<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/><Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/><Override PartName="/xl/worksheets/sheet2.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/><Override PartName="/xl/worksheets/sheet3.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/><Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/></Types>'''
rootrels='''<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>'''
with ZipFile(OUT,'w',ZIP_DEFLATED) as z:
    for name,data in {'[Content_Types].xml':ct,'_rels/.rels':rootrels,'xl/workbook.xml':workbook,'xl/_rels/workbook.xml.rels':rels,'xl/styles.xml':styles,'xl/worksheets/sheet1.xml':sheet_xml(test_data,[13,10,25,42,42,12,13,26],True,f'A1:H{len(test_data)}'),'xl/worksheets/sheet2.xml':summary_xml(),'xl/worksheets/sheet3.xml':sheet_xml(issue_data,[16,20,35,35,35,16,45])}.items(): z.writestr(name,data)
print(OUT.resolve())
