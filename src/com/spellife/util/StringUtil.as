package com.spellife.util
{
	
	/**
	 * 	Class that contains static utility methods for manipulating Strings.
	 * 
	 * 	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@tiptext
	 */		
	public class StringUtil
	{
		
		
		/**
		 *	Does a case insensitive compare or two strings and returns true if
		 *	they are equal.
		 * 
		 *	@param s1 The first string to compare.
		 *
		 *	@param s2 The second string to compare.
		 *
		 *	@returns A boolean value indicating whether the strings' values are 
		 *	equal in a case sensitive compare.	
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */			
		public static function stringsAreEqual(s1:String, s2:String, 
											   caseSensitive:Boolean):Boolean
		{
			if(caseSensitive)
			{
				return (s1 == s2);
			}
			else
			{
				return (s1.toUpperCase() == s2.toUpperCase());
			}
		}
		
		/**
		 *	Removes whitespace from the front and the end of the specified
		 *	string.
		 * 
		 *	@param input The String whose beginning and ending whitespace will
		 *	will be removed.
		 *
		 *	@returns A String with whitespace removed from the begining and end	
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */			
		public static function trim(input:String):String
		{
			return StringUtil.ltrim(StringUtil.rtrim(input));
		}
		
		/**
		 *	Removes whitespace from the front of the specified string.
		 * 
		 *	@param input The String whose beginning whitespace will will be removed.
		 *
		 *	@returns A String with whitespace removed from the begining	
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */	
		public static function ltrim(input:String):String
		{
			var size:Number = input.length;
			for(var i:Number = 0; i < size; i++)
			{
				if(input.charCodeAt(i) > 32)
				{
					return input.substring(i);
				}
			}
			return "";
		}
		
		/**
		 *	Removes whitespace from the end of the specified string.
		 * 
		 *	@param input The String whose ending whitespace will will be removed.
		 *
		 *	@returns A String with whitespace removed from the end	
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */	
		public static function rtrim(input:String):String
		{
			var size:Number = input.length;
			for(var i:Number = size; i > 0; i--)
			{
				if(input.charCodeAt(i - 1) > 32)
				{
					return input.substring(0, i);
				}
			}
			
			return "";
		}
		
		/**
		 *	Determines whether the specified string begins with the spcified prefix.
		 * 
		 *	@param input The string that the prefix will be checked against.
		 *
		 *	@param prefix The prefix that will be tested against the string.
		 *
		 *	@returns True if the string starts with the prefix, false if it does not.
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */	
		public static function beginsWith(input:String, prefix:String):Boolean
		{			
			return (prefix == input.substring(0, prefix.length));
		}	
		
		/**
		 *	Determines whether the specified string ends with the spcified suffix.
		 * 
		 *	@param input The string that the suffic will be checked against.
		 *
		 *	@param prefix The suffic that will be tested against the string.
		 *
		 *	@returns True if the string ends with the suffix, false if it does not.
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */	
		public static function endsWith(input:String, suffix:String):Boolean
		{
			return (suffix == input.substring(input.length - suffix.length));
		}	
		
		/**
		 *	Removes all instances of the remove string in the input string.
		 * 
		 *	@param input The string that will be checked for instances of remove
		 *	string
		 *
		 *	@param remove The string that will be removed from the input string.
		 *
		 *	@returns A String with the remove string removed.
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */	
		public static function remove(input:String, remove:String):String
		{
			return StringUtil.replace(input, remove, "");
		}
		
		/**
		 *	Replaces all instances of the replace string in the input string
		 *	with the replaceWith string.
		 * 
		 *	@param input The string that instances of replace string will be 
		 *	replaces with removeWith string.
		 *
		 *	@param replace The string that will be replaced by instances of 
		 *	the replaceWith string.
		 *
		 *	@param replaceWith The string that will replace instances of replace
		 *	string.
		 *
		 *	@returns A new String with the replace string replaced with the 
		 *	replaceWith string.
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function replace(input:String, replace:String, replaceWith:String):String
		{
			return input.split(replace).join(replaceWith);
		}
		
		
		/**
		 *	Specifies whether the specified string is either non-null, or contains
		 *  	characters (i.e. length is greater that 0)
		 * 
		 *	@param s The string which is being checked for a value
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */		
		public static function stringHasValue(s:String):Boolean
		{
			//todo: this needs a unit test
			return (s != null && s.length > 0);			
		}
		
		/**
		 *  Substitutes "{n}" tokens within the specified string
		 *  with the respective arguments passed in.
		 *
		 *  @param str The string to make substitutions in.
		 *  This string can contain special tokens of the form
		 *  <code>{n}</code>, where <code>n</code> is a zero based index,
		 *  that will be replaced with the additional parameters
		 *  found at that index if specified.
		 *
		 *  @param rest Additional parameters that can be substituted
		 *  in the <code>str</code> parameter at each <code>{n}</code>
		 *  location, where <code>n</code> is an integer (zero based)
		 *  index value into the array of values specified.
		 *  If the first parameter is an array this array will be used as
		 *  a parameter list.
		 *  This allows reuse of this routine in other methods that want to
		 *  use the ... rest signature.
		 *  For example <pre>
		 *     public function myTracer(str:String, ... rest):void
		 *     {
		 *         label.text += StringUtil.substitute(str, rest) + "\n";
		 *     } </pre>
		 *
		 *  @return New string with all of the <code>{n}</code> tokens
		 *  replaced with the respective arguments specified.
		 *
		 *  @example
		 *
		 *  var str:String = "here is some info "{0}" and {1}";
		 *  Tracer.info(StringUtil.substitute(str, 15.4, true));
		 *
		 *  // this will output the following string:
		 *  // "here is some info "15.4" and true"
		 */
		public static function substitute(input:String, ... rest):String
		{
			// Replace all of the parameters in the msg string.
			var len:uint = rest.length;
			var args:Array;
			if (len == 1 && rest[0] is Array)
			{
				args = rest[0] as Array;
				len = args.length;
			}
			else
			{
				args = rest;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				input = input.replace(new RegExp("\\{" + i + "\\}", "g"), args[i]);
			}
			return input;
		}
		
		/**
		 * HTML encode
		 */
		public static function htmlEncode(input:String):String
		{
			input = replace(input, "&", "&amp;");
			input = replace(input, "\"", "&quot;");
			input = replace(input, "<", "&lt;");
			input = replace(input, ">", "&gt;");
			return input;
		}
	}
}