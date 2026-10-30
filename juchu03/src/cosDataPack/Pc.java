package cosDataPack;

/**
 * PC商品クラス。
 * ver.2で追加するPC固有情報を保持する。
 */
public class Pc extends Shohin {
    // ***** ここから ver.2: PC固有項目を追加
    // 作業内容: DBのPC_TABLEから取得したPC情報を保持する
    private String color;
    private String kataban;
    private String screenSize;
    private String screenResolution;
    private String cpu;
    private String memory;
    private String hdd;
    private String drive;
    private String network;
    private String os;
    private String software;
    private String battery;
    private String accessories;
    private String warranty;
    private String weight;
    private String size;
    // ***** ここまで ver.2

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public String getKataban() { return kataban; }
    public void setKataban(String kataban) { this.kataban = kataban; }
    public String getScreenSize() { return screenSize; }
    public void setScreenSize(String screenSize) { this.screenSize = screenSize; }
    public String getScreenResolution() { return screenResolution; }
    public void setScreenResolution(String screenResolution) { this.screenResolution = screenResolution; }
    public String getCpu() { return cpu; }
    public void setCpu(String cpu) { this.cpu = cpu; }
    public String getMemory() { return memory; }
    public void setMemory(String memory) { this.memory = memory; }
    public String getHdd() { return hdd; }
    public void setHdd(String hdd) { this.hdd = hdd; }
    public String getDrive() { return drive; }
    public void setDrive(String drive) { this.drive = drive; }
    public String getNetwork() { return network; }
    public void setNetwork(String network) { this.network = network; }
    public String getOs() { return os; }
    public void setOs(String os) { this.os = os; }
    public String getSoftware() { return software; }
    public void setSoftware(String software) { this.software = software; }
    public String getBattery() { return battery; }
    public void setBattery(String battery) { this.battery = battery; }
    public String getAccessories() { return accessories; }
    public void setAccessories(String accessories) { this.accessories = accessories; }
    public String getWarranty() { return warranty; }
    public void setWarranty(String warranty) { this.warranty = warranty; }
    public String getWeight() { return weight; }
    public void setWeight(String weight) { this.weight = weight; }
    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }
}
