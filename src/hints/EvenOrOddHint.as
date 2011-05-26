package hints 
{
	/**
	 * 数字が偶数か奇数かを求め、ヒントとして利用します。
	 * @author Seacolor
	 */
	public class EvenOrOddHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function EvenOrOddHint(correct_number:Vector.<int>) 
		{
			super(correct_number);
			
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get hintLevel():HintLevel 
		{
			return HintLevel.MIDDLE;
		}
		
		/**
		 * 偶数か奇数かでヒントを生成します。
		 */
		override protected function createHints():void 
		{
			for (var i:int = 0; i < correct_number.length; i++) {
				var showNumber:int = i + 1;
				if (correct_number[i] % 2 == 0) {
					hint_list.push(showNumber + " 番目は偶数");
				} else {
					hint_list.push(showNumber + " 番目は奇数");
				}
			}
		}
	}

}