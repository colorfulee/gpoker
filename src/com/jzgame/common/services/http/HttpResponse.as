package com.jzgame.common.services.http
{
	/**
	 * 
	 * @author Rakuten
	 * 
	 */	
	public dynamic class HttpResponse implements IHttpResponse
	{
		public function HttpResponse(data:*)
		{
			for (var i:* in data)
			this[i] = data[i]
		}
	}
}