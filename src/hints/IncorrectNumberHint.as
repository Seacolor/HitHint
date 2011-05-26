package hints 
{
	/**
	 * 不正解となる数字をヒントとして利用します。
	 * @author Seacolor
	 */
	public class IncorrectNumberHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function IncorrectNumberHint(correct_number:Vector.<int>) 
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
		 * 不正解となる数字でヒントを生成します。
		 */
		override protected function createHints():void 
		{
			for (var i:int = 0; i < correct_number.length; i++) {
				for (var num:int = 0; num < 10; num++) {
					if (correct_number[i] != num) {
						hint_list.push((i + 1) + " 番目は " + num + " ではない");
					}
				}
			}
		}
		
	}

}