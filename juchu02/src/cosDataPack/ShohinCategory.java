package cosDataPack;

/**
 * 商品カテゴリクラス。
 * 商品のカテゴリ情報。商品カテゴリコード、商品サブカテゴリコード、商品カテゴリ名、商品サブカテゴリ名などをまとめたもの。
 * @version 1.0
 */
public class ShohinCategory {
	/** 商品カテゴリコード */
	private String gctgCD;
	/** 商品カテゴリ名 */
	private String gctgName;
	/** 商品サブカテゴリコード */
	private String gsubctgCD;
	/** 商品サブカテゴリ名 */
	private String gsubctgName;
	/** クラス名（商品テーブル名の一部） */
	private String className;

	/**
	 * コンストラクタ。
	 */
	public ShohinCategory() {
		super();
	}

	/**
	 * 商品カテゴリコードを取得する。
	 * @return 商品カテゴリコード
	 */
	public String getGctgCD() {
		return gctgCD;
	}

	/**
	 * 商品カテゴリコードを設定する。
	 * @param gctgCD 商品カテゴリコード
	 */
	public void setGctgCD(String gctgCD) {
		this.gctgCD = gctgCD;
	}

	/**
	 * 商品カテゴリ名を取得する。
	 * @return 商品カテゴリ名
	 */
	public String getGctgName() {
		return gctgName;
	}

	/**
	 * 商品カテゴリ名を設定する。
	 * @param gctgName 商品カテゴリ名
	 */
	public void setGctgName(String gctgName) {
		this.gctgName = gctgName;
	}

	/**
	 * 商品サブカテゴリコードを取得する。
	 * @return 商品サブカテゴリコード
	 */
	public String getGsubctgCD() {
		return gsubctgCD;
	}

	/**
	 * 商品サブカテゴリコードを設定する。
	 * @param gsubctgCD 商品サブカテゴリコード
	 */
	public void setGsubctgCD(String gsubctgCD) {
		this.gsubctgCD = gsubctgCD;
	}

	/**
	 * 商品サブカテゴリ名を取得する。
	 * @return 商品サブカテゴリ名
	 */
	public String getGsubctgName() {
		return gsubctgName;
	}

	/**
	 * 商品サブカテゴリ名を設定する。
	 * @param gsubctgName 商品サブカテゴリ名
	 */
	public void setGsubctgName(String gsubctgName) {
		this.gsubctgName = gsubctgName;
	}

	/**
	 * クラス名を取得する。
	 * @return クラス名
	 */
	public String getClassName() {
		return className;
	}

	/**
	 * クラス名を設定する。
	 * @param className クラス名
	 */
	public void setClassName(String className) {
		this.className = className;
	}

	/**
	 * 商品コードから商品カテゴリコードを設定する。
	 * @param goodsCD 商品コード
	 */
	public void setGctgCDFrmGoodsCD(String goodsCD) {
		// ***** ここから ver.2: 商品カテゴリコードの抽出桁数を修正
		// 作業内容: ver.2の商品コード先頭2桁をカテゴリコードとして保持する
		this.gctgCD = goodsCD.substring(0, 2);
		// ***** ここまで ver.2
	}

	/**
	 * 商品コードから商品サブカテゴリコードを設定する。
	 * @param goodsCD 商品コード
	 */
	public void setGsubctgCDFrmGoodsCD(String goodsCD) {
		// ***** ここから ver.2: 商品サブカテゴリコードの抽出桁数を修正
		// 作業内容: ver.2の商品コード先頭4桁をサブカテゴリコードとして保持する
		this.gsubctgCD = goodsCD.substring(0, 4);
		// ***** ここまで ver.2
	}
}
