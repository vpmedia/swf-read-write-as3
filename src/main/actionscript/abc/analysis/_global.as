package abc.analysis {
	/**
	 * A global scope object for this actual, running runtime.  Used as a signifier of 
	 * the global scope for the call slices being manipulated. 
	 */
	public const _global:Object = (function():* { return function():* { return this }() })() // should always be [object global]
}