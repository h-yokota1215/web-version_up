package cosDAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import cosDataPack.Av;
import cosDataPack.Shohin;
import cosDataPack.ShohinCategory;
import cosDataPack.ShohinPrimalData;

/** AV機器データをAV_TABLEから取得するDAO。 */
public class DaoAv extends DaoShohin {
    public DaoAv() { super(); }
    public DaoAv(Connection con) { super(con); }

    /** AV機器商品情報を取得する。 */
    public ArrayList<Shohin> selectData(String code, String eigyosyoCD) {
        ArrayList<Shohin> list = new ArrayList<Shohin>();
        Av av = new Av();
        ShohinPrimalData primal = new ShohinPrimalData();
        ShohinCategory category = new ShohinCategory();
        ResultSet rs = null;
        String query = "SELECT F.GOODSCD, F.GOODSNAME, F.H_TANKA, C.GCTGCD, C.GCTGNAME, "
                + "G.GSUBCTGCD, G.GSUBCTGNAME, C.CLASSNAME, M.MAKERNAME, F.IRISU, F.TANNI, "
                + "F.MAKERCD, F.COMMENT, F.IMG_URI, H.ZAIKO_CNT, H.HIKIATE_CNT, F.SHUBETU, F.OTHER, "
                + "F.COLOR, F.KATABAN, F.SCREEN_SIZE, F.SCREEN_RESOLUTION, F.OUTPUT_VOLUME, F.CAPACITY, "
                + "F.MEDIA, F.INTERFACE AS INTERFACE_VALUE, F.POWER_CONSUMPTION, F.ACCESSORIES, "
                + "F.WARRANTY, F.WEIGHT, F.SIZE FROM AV_TABLE F, GSUBCTG_TABLE G, CTR_GCTG_TABLE C, "
                + "HANBAIZAIKO" + eigyosyoCD + "_TABLE H, MAKER_TABLE M WHERE LEFT(F.GOODSCD, 2) = C.GCTGCD "
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
                av.setShohinPriData(primal);
                av.setShohinCtgInfo(category);
                av.setMakerName(rs.getString("MAKERNAME"));
                av.setIrisu(rs.getInt("IRISU"));
                av.setTanni(rs.getString("TANNI"));
                av.setMakerCD(rs.getString("MAKERCD"));
                av.setComments(rs.getString("COMMENT"));
                av.setImgURL(rs.getString("IMG_URI"));
                av.setZaikoCnt(rs.getInt("ZAIKO_CNT"));
                av.setHikiateCnt(rs.getInt("HIKIATE_CNT"));
                av.setZaikoHyouji();
                av.setShubetu(rs.getString("SHUBETU"));
                av.setOther(rs.getString("OTHER"));
                av.setColor(rs.getString("COLOR"));
                av.setKataban(rs.getString("KATABAN"));
                av.setScreenSize(rs.getString("SCREEN_SIZE"));
                av.setScreenResolution(rs.getString("SCREEN_RESOLUTION"));
                av.setOutputVolume(rs.getString("OUTPUT_VOLUME"));
                av.setCapacity(rs.getString("CAPACITY"));
                av.setMedia(rs.getString("MEDIA"));
                av.setInterfaceValue(rs.getString("INTERFACE_VALUE"));
                av.setPowerConsumption(rs.getString("POWER_CONSUMPTION"));
                av.setAccessories(rs.getString("ACCESSORIES"));
                av.setWarranty(rs.getString("WARRANTY"));
                av.setWeight(rs.getString("WEIGHT"));
                av.setSize(rs.getString("SIZE"));
                list.add(av);
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
