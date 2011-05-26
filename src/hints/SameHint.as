package hints 
{
	/**
	 * 同値の有無を求め、ヒントとして利用します。
	 * @author Seacolor
	 */
	public class SameHint extends HintTemplate 
	{
		
		/**
		 * @inheritDoc
		 */
		public function SameHint(correct_number:Vector.<int>) 
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
		 * 同値の有無をヒントとして生成します。
		 */
		override protected function createHints():void 
		{
			for (var i:int = 0; i < correct_number.length; i++) {
				for (var j:int = i + 1; j < correct_number.length; j++) {
					if (correct_number[i] == correct_number[j]) {
						hint_list.push("同じ数字はある");
						return;
					}
					
				}
			}
			
			hint_list.push("同じ数字はない");
		}
		
	}

}