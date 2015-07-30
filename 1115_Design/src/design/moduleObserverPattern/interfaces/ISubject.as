package design.moduleObserverPattern.interfaces
{
	/**
	 * @author Ben Smith
	 */
	public interface ISubject
	{
		
		function addObserver( observer : IObserve , aspect : Function ) : Boolean
		function removeObserver( observer : IObserve ) : Boolean
	}
}
