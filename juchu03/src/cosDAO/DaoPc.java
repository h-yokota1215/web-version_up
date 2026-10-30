package cosDAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import cosDataPack.Pc;
import cosDataPack.Shohin;
import cosDataPack.ShohinCategory;
import cosDataPack.ShohinPrimalData;

/** PCデータをPC_TABLEから取得するDAO。 */
public class DaoPc extends DaoShohin {
    public DaoPc() { super(); }
    public DaoPc(Connection con) { super(con); }

    /** PC商品情報を取得する。 */
    public ArrayList<Shohin> selectData(String code, String eigyosyoCD) {
        ArrayList<Shohin> list = new ArrayList<Shohin>();
        Pc pc = new Pc();
        ShohinPrimalData primal = new ShohinPrimalData();
        ShohinCategory category = new ShohinCategory();
        ResultSet rs = null;
        String query = "SELECT F.GOODSCD, F.GOODSNAME, F.H_TANKA, C.GCTGCD, C.GCTGNAME, "
                + "G.GSUBCTGCD, G.GSUBCTGNAME, C.CLASSNAME, M.MAKERNAME, F.IRISU, F.TANNI, "
                + "F.MAKERCD, F.COMMENT, F.IMG_URI, H.ZAIKO_CNT, H.HIKIATE_CNT, F.SHUBETU, F.OTHER, "
                + "F.COLOR, F.KATABAN, F.SCREEN_SIZE, F.SCREEN_RESOLUTION, F.CPU, F.MEMORY, F.HDD, "
                + "F.DRIVE, F.NETWORK, F.OS, F.SOFTWARE, F.BATTERY, F.ACCESSORIES, F.WARRANTY, "
                + "F.WEIGHT, F.SIZE FROM PC_TABLE F, GSUBCTG_TABLE G, CTR_GCTG_TABLE C, HANBAIZAIKO"
                + eigyosyoCD + "_TABLE H, MAKER_TABLE M WHERE LEFT(F.GOODSCD, 2) = C.GCTGCD "
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
                pc.setShohinPriData(primal);
                pc.setShohinCtgInfo(category);
                pc.setMakerName(rs.getString("MAKERNAME"));
                pc.setIrisu(rs.getInt("IRISU"));
                pc.setTanni(rs.getString("TANNI"));
                pc.setMakerCD(rs.getString("MAKERCD"));
                pc.setComments(rs.getString("COMMENT"));
                pc.setImgURL(rs.getString("IMG_URI"));
                pc.setZaikoCnt(rs.getInt("ZAIKO_CNT"));
                pc.setHikiateCnt(rs.getInt("HIKIATE_CNT"));
                pc.setZaikoHyouji();
                pc.setShubetu(rs.getString("SHUBETU"));
                pc.setOther(rs.getString("OTHER"));
                pc.setColor(rs.getString("COLOR"));
                pc.setKataban(rs.getString("KATABAN"));
                pc.setScreenSize(rs.getString("SCREEN_SIZE"));
                pc.setScreenResolution(rs.getString("SCREEN_RESOLUTION"));
                pc.setCpu(rs.getString("CPU"));
                pc.setMemory(rs.getString("MEMORY"));
                pc.setHdd(rs.getString("HDD"));
                pc.setDrive(rs.getString("DRIVE"));
                pc.setNetwork(rs.getString("NETWORK"));
                pc.setOs(rs.getString("OS"));
                pc.setSoftware(rs.getString("SOFTWARE"));
                pc.setBattery(rs.getString("BATTERY"));
                pc.setAccessories(rs.getString("ACCESSORIES"));
                pc.setWarranty(rs.getString("WARRANTY"));
                pc.setWeight(rs.getString("WEIGHT"));
                pc.setSize(rs.getString("SIZE"));
                list.add(pc);
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
