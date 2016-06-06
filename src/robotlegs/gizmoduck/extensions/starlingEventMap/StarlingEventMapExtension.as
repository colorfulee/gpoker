//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.gizmoduck.extensions.starlingEventMap
{
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.gizmoduck.extensions.starlingEventMap.api.IEventMap;
	import robotlegs.gizmoduck.extensions.starlingEventMap.impl.EventMap;

	/**
	 * An Event Map keeps track of listeners and provides the ability
	 * to unregister all listeners with a single method call.
	 */
	public class StarlingEventMapExtension implements IExtension
	{

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function extend(context:IContext):void
		{
			context.injector.map(IEventMap).toType(EventMap);
		}
	}
}
