import zipfile
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).parent
WORKSPACE = ROOT.parent.parent
TEMPLATE = WORKSPACE / "テスト報告書_ひな形.pptx"
OUTPUT = WORKSPACE / "ver.2_テスト報告書_改訂版.pptx"
TEXT = "{http://schemas.openxmlformats.org/drawingml/2006/main}t"

replacements = {
    "slide1.xml": [
        "ver.2 テスト報告書", "食品・AV・PC追加", "作成日 2026/10/23",
        "対象", "juchu02", "1"
    ],
    "slide2.xml": [
        "テスト実施結果", "テスト項目・結果一覧（詳細は添付Excel）",
        "区分\n機能\n単体\n結合\n統合\n回帰",
        "主なテスト項目\nカテゴリ・サブカテゴリ検索\n新商品詳細・画像\nカート・受注・在庫引当\n既存文具・書籍回帰",
        "判定\n合格\n合格\n合格\n部分確認あり／対象外あり",
        "実施件数\n15項目\n10項目\n7項目\n6項目／6項目\n全43項目"
    ],
    "slide3.xml": [
        "3", "実行結果", "テスト結果の詳細", "テスト結果", "期待結果", "実施結果", "V2",
        "テスト詳細報告", "合格40／部分確認3／対象外2／未実施0",
        "対象: 検索→詳細→画像→カート→受注→回帰",
        "新3カテゴリ・既存カテゴリ", "確認項目", "43項目を単体・結合・統合・回帰で確認",
        "期待結果", "検索63件、詳細765件、画像765件、食品受注、在庫不足、回帰",
        "未登録コードはjuchu01でも同じ空レスポンス。別課題として報告"
    ],
    "slide4.xml": [
        "4", "ID", "重要度", "事象・課題内容", "ステータス / 方針",
        "V2-ISSUE-001", "対象外", "参考記録", "画面から操作できない不正コード送信時の空レスポンス（ST-006/D-014）",
        "ver.2正式テスト対象外。将来の異常系・セキュリティテストで別途対応", "V2-TEST-001", "合格", "合格",
        "食品受注・在庫引当", "受注2610000002、明細1件、合計400、引当更新", "V2-TEST-002",
        "部分確認", "合格", "AV/PC受注、既存カート操作等", "AV/PC受注は部分確認、既存カート操作は完了", "",
        "残存課題・インシデント一覧", "今後の対応方針",
        "・不正コード送信は正式テスト対象外として別管理",
        "・Chrome手動確認は別途実施"
    ],
}

with zipfile.ZipFile(TEMPLATE, "r") as source:
    files = {name: source.read(name) for name in source.namelist()}

for slide, values in replacements.items():
    name = "ppt/slides/" + slide
    root = ET.fromstring(files[name])
    nodes = root.findall(".//" + TEXT)
    if len(nodes) != len(values):
        raise RuntimeError(f"{slide}: {len(nodes)} != {len(values)}")
    for node, value in zip(nodes, values):
        node.text = value
    files[name] = ET.tostring(root, encoding="utf-8", xml_declaration=True)

with zipfile.ZipFile(OUTPUT, "w", zipfile.ZIP_DEFLATED) as target:
    for name, data in files.items():
        target.writestr(name, data)

print(OUTPUT)
