package design.moduleObserverPattern.abstractions
{

	/**
	 * @author Ben Smith
	 */
	public class Module extends Object
	{
		private var _twitterName : String

		public function Module( userName : String )
		{
			_twitterName = userName
		}

		public function get twitterName() : String
		{
			return _twitterName;
		}

		public function set twitterName( twitterName : String ) : void
		{
			_twitterName = twitterName;
		}
	}
}
