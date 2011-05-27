package hints 
{
	/**
	 * 倍数を求め、ヒントとして利用します。
	 * @author Seacolor
	 */
	public class MultipleHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function MultipleHint(correct_number:Vector.<int>) 
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
		 * 数字の倍数でヒントを生成します。
		 */
		override protected function createHints():void 
		{
			for (var i:int = 0; i < correct_number.length; i++) {
				if (correct_number[i] == 0) {
					continue;
				}
				
				var showNumber:int = i + 1;
				
				for (var j:int = i + 1; j < correct_number.length; j++) {
					var showNextNumber:int = j + 1;
					
					for (var k:int = 2; k <= 3; k++) {
						if (correct_number[i] * k == correct_number[j]) {
							hint_list.push(showNumber + " 番目は " + showNextNumber + " 番目の " + k + " 分の 1");
						}
						if (correct_number[i] / k == correct_number[j]) {
							hint_list.push(showNumber + " 番目は " + showNextNumber + " 番目の " + k + " 倍");
						}
					}
				}
			}
		}
		
	}

}