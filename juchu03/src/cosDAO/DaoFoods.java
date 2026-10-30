package cosDAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import cosDataPack.Foods;
import cosDataPack.Shohin;
import cosDataPack.ShohinCategory;
import cosDataPack.ShohinPrimalData;

/** 食品データをFOODS_TABLEから取得するDAO。 */
public class DaoFoods extends DaoShohin {
    public DaoFoods() { super(); }
    public DaoFoods(Connection con) { super(con); }

    /**
     * 食品商品情報を取得する。
     * @param code 商品コード
     * @param eigyosyoCD 営業所コード
     * @return 食品商品リスト
     */
    public ArrayList<Shohin> selectData(String code, String eigyosyoCD) {
        ArrayList<Shohin> list = new ArrayList<Shohin>();
        Foods food = new Foods();
        ShohinPrimalData primal = new ShohinPrimalData();
        ShohinCategory category = new ShohinCategory();
        ResultSet rs = null;
        String query = "SELECT F.GOODSCD, F.GOODSNAME, F.H_TANKA, C.GCTGCD, C.GCTGNAME, "
                + "G.GSUBCTGCD, G.GSUBCTGNAME, C.CLASSNAME, M.MAKERNAME, F.IRISU, F.TANNI, "
                + "F.MAKERCD, F.COMMENT, F.IMG_URI, H.ZAIKO_CNT, H.HIKIATE_CNT, F.SHUBETU, "
                + "F.OTHER, F.TASTE, F.CONTENT, F.COUNTRY, F.CALORIE, F.INGREDIENT, F.NUTRIENTS "
                + "FROM FOODS_TABLE F, GSUBCTG_TABLE G, CTR_GCTG_TABLE C, HANBAIZAIKO" + eigyosyoCD
                + "_TABLE H, MAKER_TABLE M WHERE LEFT(F.GOODSCD, 2) = C.GCTGCD "
                + "AND LEFT(F.GOODSCD, 4) = G.GSUBCTGCD AND F.GOODSCD = H.GOODSCD "
                + "AND F.MAKERCD = M.MAKERCD AND F.GOODSCD = '" + code + "'";
        creStatement();
        try {
            rs = stmt.executeQuery(query);
            if (rs.next()) {
                category.setGctgCD(rs.getString("GCTGCD"));
                category.setGctgName(rs.getString("GCTGNAME"));
                category.setGsubctgCD(rs.getString("GSUBCTGCD"));
                category.setGsubctgName(rs.getString("GSUBCTGNAME"));
                category.setClassName(rs.getString("CLASSNAME"));
                primal.setGoodsCD(rs.getString("GOODSCD"));
                primal.setGoodsName(rs.getString("GOODSNAME"));
                primal.setHtanka(rs.getInt("H_TANKA"));
                food.setShohinPriData(primal);
                food.setShohinCtgInfo(category);
                food.setMakerName(rs.getString("MAKERNAME"));
                food.setIrisu(rs.getInt("IRISU"));
                food.setTanni(rs.getString("TANNI"));
                food.setMakerCD(rs.getString("MAKERCD"));
                food.setComments(rs.getString("COMMENT"));
                food.setImgURL(rs.getString("IMG_URI"));
                food.setZaikoCnt(rs.getInt("ZAIKO_CNT"));
                food.setHikiateCnt(rs.getInt("HIKIATE_CNT"));
                food.setZaikoHyouji();
                food.setShubetu(rs.getString("SHUBETU"));
                food.setOther(rs.getString("OTHER"));
                food.setTaste(rs.getString("TASTE"));
                food.setContent(rs.getString("CONTENT"));
                food.setCountry(rs.getString("COUNTRY"));
                food.setCalorie(rs.getString("CALORIE"));
                food.setIngredient(rs.getString("INGREDIENT"));
                food.setNutrients(rs.getString("NUTRIENTS"));
                list.add(food);
            } else {
                list = null;
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            list = null;
        }
        closeStatement();
        return list;
    }
}
