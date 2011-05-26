package hints 
{
	/**
	 * 正解となる数字以下の数字をヒントとして利用します。
	 * @author Seacolor
	 */
	public class LessHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function LessHint(correct_number:Vector.<int>) 
		{
			super(correct_number);
			
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get hintLevel():HintLevel 
		{
			return HintLevel.LOW;
		}
		
		/**
		 * 正解となる数字以下の数字でヒントを生成します。
		 */
		override protected function createHints():void 
		{
			for (var i:int = 0; i < correct_number.length; i++) {
				var num:int = correct_number[i];
				if (num == 0)  num = 1;
				while (num < 9) {
					hint_list.push((i + 1) + " 番目は " + num + " 以下");
					num++;
				}
			}
		}
		
	}

}