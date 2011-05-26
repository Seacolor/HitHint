package hints 
{
	/**
	 * ヒントのテンプレートクラスです。
	 * @author Seacolor
	 */
	public class HintTemplate 
	{
		/**
		 * 正解となる数字の配列
		 */
		protected var correct_number:Vector.<int>;
		/**
		 * ヒントの配列
		 */
		protected var hint_list:Vector.<String>;
		
		/**
		 * コンストラクタです。
		 * @param	correct_number	正解となる数字の配列
		 */
		public function HintTemplate(correct_number:Vector.<int>) 
		{
			this.correct_number = correct_number;
			hint_list = new Vector.<String>();
		}
		
		/**
		 * ヒントのレベルです。
		 * このメソッドはサブクラスによって実装されます。
		 */
		public function get hintLevel():HintLevel {
			return null;
		}
		
		/**
		 * 正解となる数字に関連したヒントを生成し、返却します。
		 * @return	ヒントの配列
		 */
		public function getHints():Vector.<String> {
			// ヒントの配列を生成します。
			createHints();
			// ヒントの配列を返却します。
			return hint_list;
		}
		
		/**
		 * 正解となる数字に関連したヒントを生成します。
		 * このメソッドはサブクラスによって実装されます。
		 */
		protected function createHints():void 
		{
			
		}
		
	}

}