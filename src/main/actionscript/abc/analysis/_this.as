package abc.analysis {
	/**
	 * A symbolic, singleton(-ish) value that represents an abstract "this" for interpretation.
	 */
	public const _this:* = { toString: function():* { return '[object this]' } }
}