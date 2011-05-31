package hints 
{
	[ja("{0} 番目は {1} 以下")]
	[en("No.{0} is {1} or less.")]
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
					hint_list.push(getMessage("", i + 1, num));
					num++;
				}
			}
		}
		
	}

}