package cosDataPack;

/** 個人顧客。法人と共通の顧客項目を利用する。 */
public class Kojin extends Kokyaku {
    public Kojin() {
        super();
        setYoshin_gendo(PERSONAL_CREDIT_LIMIT);
    }
}
