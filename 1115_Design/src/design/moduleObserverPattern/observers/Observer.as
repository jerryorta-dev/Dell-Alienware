package design.moduleObserverPattern.observers
{
import design.moduleObserverPattern.abstractions.Module;
import design.moduleObserverPattern.interfaces.IObserve;

/**
	 * @author Ben Smith
	 */
	public class Observer extends Module implements IObserve
	{
		public function Observer( userName : String )
		{
			super( userName )
		}

		public function notify( str : String ) : void
		{
//			trace( str )
		}
	}
}
