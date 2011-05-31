package hints 
{
	[ja("全ての数字の和は {0}")]
	[en("sum is {0}.")]
	/**
	 * 数字の和を求め、ヒントとして利用します。
	 * @author Seacolor
	 */
	public class SumHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function SumHint(correct_number:Vector.<int>) 
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
		 * 数字の和をヒントとして生成します。
		 */
		override protected function createHints():void 
		{
			var sum:int = 0;
			
			for each (var n:int in correct_number) {
				sum += n;
			}
			
			hint_list.push(getMessage("", sum));
		}
		
	}

}