package hints 
{
	/**
	 * ヒントのレベルの列挙です。
	 * @author Seacolor
	 */
	public class HintLevel 
	{
		/**
		 * 低級のヒントであり、数字の絞り込みはほぼ不可能です。
		 * 数字の絞り込みには多くの同級のヒントが必要です。
		 */
		public static const LOW:HintLevel = new HintLevel();
		/**
		 * 中級のヒントであり、数字の絞り込みはやや困難です。
		 * 数字の絞り込みには多少の同級のヒントが必要です。
		 */
		public static const MIDDLE:HintLevel = new HintLevel();
		/**
		 * 上級のヒントであり、数字の絞り込みは容易です。
		 */
		public static const TOP:HintLevel = new HintLevel();
	}

}