package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.GlobalMessageType;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class GlobalMessageResponse extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.jzgame.common.services.protobuff.GlobalMessageResponse.type", "type", (1 << 3) | com.netease.protobuf.WireType.VARINT, com.jzgame.common.services.protobuff.GlobalMessageType);

		public var type:int;

		/**
		 *  @private
		 */
		public static const MESSAGE:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.jzgame.common.services.protobuff.GlobalMessageResponse.message", "message", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var message:String;

		/**
		 *  @private
		 */
		public static const PLAYERNAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.jzgame.common.services.protobuff.GlobalMessageResponse.playername", "playername", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var playername$field:String;

		public function clearPlayername():void {
			playername$field = null;
		}

		public function get hasPlayername():Boolean {
			return playername$field != null;
		}

		public function set playername(value:String):void {
			playername$field = value;
		}

		public function get playername():String {
			return playername$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_ENUM(output, this.type);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.message);
			if (hasPlayername) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, playername$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var type$count:uint = 0;
			var message$count:uint = 0;
			var playername$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: GlobalMessageResponse.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_ENUM(input);
					break;
				case 2:
					if (message$count != 0) {
						throw new flash.errors.IOError('Bad data format: GlobalMessageResponse.message cannot be set twice.');
					}
					++message$count;
					this.message = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					if (playername$count != 0) {
						throw new flash.errors.IOError('Bad data format: GlobalMessageResponse.playername cannot be set twice.');
					}
					++playername$count;
					this.playername = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
