package cosDataPack;

/**
 * AV機器商品クラス。
 * ver.2で追加するAV機器固有情報を保持する。
 */
public class Av extends Shohin {
    // ***** ここから ver.2: AV機器固有項目を追加
    // 作業内容: DBのAV_TABLEから取得したAV機器情報を保持する
    private String color;
    private String kataban;
    private String screenSize;
    private String screenResolution;
    private String outputVolume;
    private String capacity;
    private String media;
    private String interfaceValue;
    private String powerConsumption;
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
    public String getOutputVolume() { return outputVolume; }
    public void setOutputVolume(String outputVolume) { this.outputVolume = outputVolume; }
    public String getCapacity() { return capacity; }
    public void setCapacity(String capacity) { this.capacity = capacity; }
    public String getMedia() { return media; }
    public void setMedia(String media) { this.media = media; }
    public String getInterfaceValue() { return interfaceValue; }
    public void setInterfaceValue(String interfaceValue) { this.interfaceValue = interfaceValue; }
    public String getPowerConsumption() { return powerConsumption; }
    public void setPowerConsumption(String powerConsumption) { this.powerConsumption = powerConsumption; }
    public String getAccessories() { return accessories; }
    public void setAccessories(String accessories) { this.accessories = accessories; }
    public String getWarranty() { return warranty; }
    public void setWarranty(String warranty) { this.warranty = warranty; }
    public String getWeight() { return weight; }
    public void setWeight(String weight) { this.weight = weight; }
    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }
}
