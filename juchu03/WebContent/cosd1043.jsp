<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="cosDataPack.ShohinPrimalData"%>
<%@ page import="cosDataPack.Av"%>
<%@ page import="java.text.DecimalFormat"%>

<!-- ***** ここから ver.2: AV機器商品詳細画面を追加 -->
<!-- 作業内容: 既存詳細画面の構造を維持し、AV機器固有項目を表示する -->
<jsp:useBean id="shohin" scope="session" class="cosDataPack.Shohin" />
<html lang="ja">
<%
    // ***** ここから ver.2: AV機器詳細データを取得
    // 作業内容: セッションの商品をAv型へ変換して表示する
    Av av = (Av) shohin;
    ShohinPrimalData sp = av.getShohinPriData();
    DecimalFormat nf = new DecimalFormat("###,###,###");
    String sTanka = nf.format(av.getShohinPriData().getHtanka());
    // ***** ここまで ver.2
%>
<head><meta charset="UTF-8"><link rel="stylesheet" href="css/common1.css"><title>Office Goody</title></head>
<body id="cosd1043"><div id="container">
    <div id="header"><h1>Office Goody</h1><h2>Customer Order System</h2></div>
    <div id="contents"><form action="CosServlet" method="post">
        <div id="contents_header"><p><small>COSD1043</small></p><h3>商品の詳細説明</h3></div>
        <div id="contents_nav"></div><hr><div id="contents_body">
            <div id="goods_img"><table><tr><td><img src="<%=av.getImgURL()%>" alt="<%=sp.getGoodsCD()%>" title="サンプル" /></td></tr>
                <tr><td style="border: 1px solid #000000; text-align: left; vertical-align: top; height: 10em;"><%=av.getComments()%></td></tr></table></div>
            <div id="goods_exp"><table>
                <tr><th>商品コード</th><td><%=sp.getGoodsCD()%></td></tr><tr><th>商品名</th><td><%=sp.getGoodsName()%></td></tr>
                <tr><th>単価</th><td><%=sTanka%>円</td></tr><tr><th>在庫</th><td><%=av.getZaikoHyouji()%></td></tr>
                <tr><th>メーカー名</th><td><%=av.getMakerName()%></td></tr><tr><th>セット数</th><td><%=av.getIrisu()%></td></tr>
                <!-- ***** ここから ver.2: AV機器固有項目を表示 -->
                <!-- 作業内容: AV機器の仕様項目を表示する -->
                <tr><th>色</th><td><%=av.getColor()%></td></tr><tr><th>型番</th><td><%=av.getKataban()%></td></tr>
                <tr><th>画面サイズ</th><td><%=av.getScreenSize()%></td></tr><tr><th>画面解像度</th><td><%=av.getScreenResolution()%></td></tr>
                <tr><th>出力音量</th><td><%=av.getOutputVolume()%></td></tr><tr><th>記憶容量</th><td><%=av.getCapacity()%></td></tr>
                <tr><th>対応メディア</th><td><%=av.getMedia()%></td></tr><tr><th>インターフェース</th><td><%=av.getInterfaceValue()%></td></tr>
                <tr><th>消費電力</th><td><%=av.getPowerConsumption()%></td></tr><tr><th>付属品</th><td><%=av.getAccessories()%></td></tr>
                <tr><th>保証期間</th><td><%=av.getWarranty()%></td></tr><tr><th>質量</th><td><%=av.getWeight()%></td></tr>
                <tr><th>寸法</th><td><%=av.getSize()%></td></tr><tr><th>その他</th><td><%=av.getOther()%></td></tr>
                <!-- ***** ここまで ver.2 -->
            </table><br></div>
        </div>
    </form></div>
    <div id="footer"><address>&copy;Office Goody 2011 All rights reserved Office Goody Co,Ltd.</address></div>
</div></body></html>
<!-- ***** ここまで ver.2: AV機器商品詳細画面を追加 -->
