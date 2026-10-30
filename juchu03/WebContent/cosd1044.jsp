<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="cosDataPack.ShohinPrimalData"%>
<%@ page import="cosDataPack.Pc"%>
<%@ page import="java.text.DecimalFormat"%>

<!-- ***** ここから ver.2: PC商品詳細画面を追加 -->
<!-- 作業内容: 既存詳細画面の構造を維持し、PC固有項目を表示する -->
<jsp:useBean id="shohin" scope="session" class="cosDataPack.Shohin" />
<html lang="ja">
<%
    // ***** ここから ver.2: PC詳細データを取得
    // 作業内容: セッションの商品をPc型へ変換して表示する
    Pc pc = (Pc) shohin;
    ShohinPrimalData sp = pc.getShohinPriData();
    DecimalFormat nf = new DecimalFormat("###,###,###");
    String sTanka = nf.format(pc.getShohinPriData().getHtanka());
    // ***** ここまで ver.2
%>
<head><meta charset="UTF-8"><link rel="stylesheet" href="css/common1.css"><title>Office Goody</title></head>
<body id="cosd1044"><div id="container">
    <div id="header"><h1>Office Goody</h1><h2>Customer Order System</h2></div>
    <div id="contents"><form action="CosServlet" method="post">
        <div id="contents_header"><p><small>COSD1044</small></p><h3>商品の詳細説明</h3></div>
        <div id="contents_nav"></div><hr><div id="contents_body">
            <div id="goods_img"><table><tr><td><img src="<%=pc.getImgURL()%>" alt="<%=sp.getGoodsCD()%>" title="サンプル" /></td></tr>
                <tr><td style="border: 1px solid #000000; text-align: left; vertical-align: top; height: 10em;"><%=pc.getComments()%></td></tr></table></div>
            <div id="goods_exp"><table>
                <tr><th>商品コード</th><td><%=sp.getGoodsCD()%></td></tr><tr><th>商品名</th><td><%=sp.getGoodsName()%></td></tr>
                <tr><th>単価</th><td><%=sTanka%>円</td></tr><tr><th>在庫</th><td><%=pc.getZaikoHyouji()%></td></tr>
                <tr><th>メーカー名</th><td><%=pc.getMakerName()%></td></tr><tr><th>セット数</th><td><%=pc.getIrisu()%></td></tr>
                <!-- ***** ここから ver.2: PC固有項目を表示 -->
                <!-- 作業内容: PCの仕様項目を表示する -->
                <tr><th>色</th><td><%=pc.getColor()%></td></tr><tr><th>型番</th><td><%=pc.getKataban()%></td></tr>
                <tr><th>画面サイズ</th><td><%=pc.getScreenSize()%></td></tr><tr><th>画面解像度</th><td><%=pc.getScreenResolution()%></td></tr>
                <tr><th>CPU</th><td><%=pc.getCpu()%></td></tr><tr><th>メモリ容量</th><td><%=pc.getMemory()%></td></tr>
                <tr><th>HDD容量</th><td><%=pc.getHdd()%></td></tr><tr><th>ドライブ</th><td><%=pc.getDrive()%></td></tr>
                <tr><th>ネットワーク</th><td><%=pc.getNetwork()%></td></tr><tr><th>OS</th><td><%=pc.getOs()%></td></tr>
                <tr><th>統合ソフト</th><td><%=pc.getSoftware()%></td></tr><tr><th>バッテリ</th><td><%=pc.getBattery()%></td></tr>
                <tr><th>付属品</th><td><%=pc.getAccessories()%></td></tr><tr><th>保証期間</th><td><%=pc.getWarranty()%></td></tr>
                <tr><th>質量</th><td><%=pc.getWeight()%></td></tr><tr><th>寸法</th><td><%=pc.getSize()%></td></tr>
                <tr><th>その他</th><td><%=pc.getOther()%></td></tr>
                <!-- ***** ここまで ver.2 -->
            </table><br></div>
        </div>
    </form></div>
    <div id="footer"><address>&copy;Office Goody 2011 All rights reserved Office Goody Co,Ltd.</address></div>
</div></body></html>
<!-- ***** ここまで ver.2: PC商品詳細画面を追加 -->
