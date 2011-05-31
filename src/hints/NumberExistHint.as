package hints 
{
	[ja(exist="{0} はある", notexist="{0} はない")]
	[en(exist="{0} exists.", notexist="{0} not exists.")]
	/**
	 * 各数字の有無を求め、ヒントとして利用します。
	 * @author Seacolor
	 */
	public class NumberExistHint extends HintTemplate 
	{
		/**
		 * @inheritDoc
		 */
		public function NumberExistHint(correct_number:Vector.<int>) 
		{
			super(correct_number);
			
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get hintLevel():HintLevel 
		{
			return HintLevel.TOP;
		}
		
		/**
		 * 各数字の有無でヒントを生成します。
		 */
		override protected function createHints():void 
		{
			loop_num : for (var i:int = 0; i <= 9; i++) {
				for each (var n:int in correct_number) {
					if (n == i) {
						hint_list.push(getMessage("exist", i));
						continue loop_num;
					}
				}
				
				hint_list.push(getMessage("notexist", i));
			}
		}
		
	}

}