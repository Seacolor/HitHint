package hints 
{
	[ja(fraction="{0} 番目は {1} 番目の {2} 分の 1", multiple="{0} 番目は {1} 番目の {2} 倍")]
	[en(fraction="No.{0} is 1/{2} of No.{1}", multiple="No.{0} is {2} times of No.{1}")]
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
							hint_list.push(getMessage("fraction", showNumber, showNextNumber, k));
						}
						if (correct_number[i] / k == correct_number[j]) {
							hint_list.push(getMessage("multiple", showNumber, showNextNumber, k));
						}
					}
				}
			}
		}
		
	}

}