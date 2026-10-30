package cosDataPack;

/**
 * 食品商品クラス。
 * ver.2で追加する食品固有情報を保持する。
 */
public class Foods extends Shohin {
    // ***** ここから ver.2: 食品固有項目を追加
    // 作業内容: DBのFOODS_TABLEから取得した食品情報を保持する
    private String taste;
    private String content;
    private String country;
    private String calorie;
    private String ingredient;
    private String nutrients;
    // ***** ここまで ver.2

    public String getTaste() { return taste; }
    public void setTaste(String taste) { this.taste = taste; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }
    public String getCalorie() { return calorie; }
    public void setCalorie(String calorie) { this.calorie = calorie; }
    public String getIngredient() { return ingredient; }
    public void setIngredient(String ingredient) { this.ingredient = ingredient; }
    public String getNutrients() { return nutrients; }
    public void setNutrients(String nutrients) { this.nutrients = nutrients; }
}
