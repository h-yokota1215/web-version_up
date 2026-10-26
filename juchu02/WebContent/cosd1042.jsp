<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="cosDataPack.ShohinPrimalData"%>
<%@ page import="cosDataPack.Foods"%>
<%@ page import="java.text.DecimalFormat"%>

<!-- ***** ここから ver.2: 食品商品詳細画面を追加 -->
<!-- 作業内容: 既存詳細画面の構造を維持し、食品固有項目を表示する -->
<jsp:useBean id="shohin" scope="session" class="cosDataPack.Shohin" />
<html lang="ja">
<%
    // ***** ここから ver.2: 食品詳細データを取得
    // 作業内容: セッションの商品をFoods型へ変換して表示する
    Foods foods = (Foods) shohin;
    ShohinPrimalData sp = foods.getShohinPriData();
    DecimalFormat nf = new DecimalFormat("###,###,###");
    String sTanka = nf.format(foods.getShohinPriData().getHtanka());
    // ***** ここまで ver.2
%>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/common1.css">
<title>Office Goody</title>
</head>
<body id="cosd1042">
    <!-- コンテナ部分（ページ全体） -->
    <div id="container">
        <!-- ヘッダー部分 -->
        <div id="header"><h1>Office Goody</h1><h2>Customer Order System</h2></div>
        <!-- コンテンツ部分 -->
        <div id="contents">
            <form action="CosServlet" method="post">
                <div id="contents_header"><p><small>COSD1042</small></p><h3>商品の詳細説明</h3></div>
                <div id="contents_nav"></div><hr>
                <div id="contents_body">
                    <div id="goods_img"><table><tr><td><img src="<%=foods.getImgURL()%>" alt="<%=sp.getGoodsCD()%>" title="サンプル" /></td></tr>
                        <tr><td style="border: 1px solid #000000; text-align: left; vertical-align: top; height: 10em;"><%=foods.getComments()%></td></tr></table></div>
                    <div id="goods_exp"><table>
                        <tr><th>商品コード</th><td><%=sp.getGoodsCD()%></td></tr>
                        <tr><th>商品名</th><td><%=sp.getGoodsName()%></td></tr>
                        <tr><th>単価</th><td><%=sTanka%>円</td></tr>
                        <tr><th>在庫</th><td><%=foods.getZaikoHyouji()%></td></tr>
                        <tr><th>メーカー名</th><td><%=foods.getMakerName()%></td></tr>
                        <tr><th>セット数</th><td><%=foods.getIrisu()%></td></tr>
                        <!-- ***** ここから ver.2: 食品固有項目を表示 -->
                        <!-- 作業内容: 味・内容量・製造国などを表示する -->
                        <tr><th>味</th><td><%=foods.getTaste()%></td></tr>
                        <tr><th>内容量</th><td><%=foods.getContent()%></td></tr>
                        <tr><th>製造国</th><td><%=foods.getCountry()%></td></tr>
                        <tr><th>熱量</th><td><%=foods.getCalorie()%></td></tr>
                        <tr><th>原材料</th><td><%=foods.getIngredient()%></td></tr>
                        <tr><th>栄養成分</th><td><%=foods.getNutrients()%></td></tr>
                        <tr><th>その他</th><td><%=foods.getOther()%></td></tr>
                        <!-- ***** ここまで ver.2 -->
                    </table><br></div>
                </div>
            </form>
        </div>
        <div id="footer"><address>&copy;Office Goody 2011 All rights reserved Office Goody Co,Ltd.</address></div>
    </div>
</body>
</html>
<!-- ***** ここまで ver.2: 食品商品詳細画面を追加 -->
