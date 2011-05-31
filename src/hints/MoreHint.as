package hints 
{
	[ja("{0} 番目は {1} 以上")]
	[en("No.{0} is {1} or more.")]
	/**
	 * 正解となる数字以上の数字をヒントとして利用します。
	 * @author Seacolor
	 */
	public class MoreHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function MoreHint(correct_number:Vector.<int>) 
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
		 * 正解となる数字以上の数字でヒントを生成します。
		 */
		override protected function createHints():void 
		{
			for (var i:int = 0; i < correct_number.length; i++) {
				var limit:int = correct_number[i];
				if (limit == 9) limit = 8;
				for (var num:int = 1; num <= limit; num++) {
					hint_list.push(getMessage("", i + 1, num));
				}
			}
		}
		
	}

}