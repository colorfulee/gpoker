package com.jzgame.common.services.protobuff {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.jzgame.common.services.protobuff.PlayerInfo;
	import com.jzgame.common.services.protobuff.TableInfo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class LoginResponse extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TABLEINFO:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.LoginResponse.tableinfo", "tableinfo", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.TableInfo; });

		public var tableinfo:com.jzgame.common.services.protobuff.TableInfo;

		/**
		 *  @private
		 */
		public static const PLAYERINFO:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.jzgame.common.services.protobuff.LoginResponse.playerinfo", "playerinfo", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.jzgame.common.services.protobuff.PlayerInfo; });

		[ArrayElementType("com.jzgame.common.services.protobuff.PlayerInfo")]
		public var playerinfo:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.tableinfo);
			for (var playerinfo$index:uint = 0; playerinfo$index < this.playerinfo.length; ++playerinfo$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.playerinfo[playerinfo$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var tableinfo$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (tableinfo$count != 0) {
						throw new flash.errors.IOError('Bad data format: LoginResponse.tableinfo cannot be set twice.');
					}
					++tableinfo$count;
					this.tableinfo = new com.jzgame.common.services.protobuff.TableInfo();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.tableinfo);
					break;
				case 2:
					this.playerinfo.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.jzgame.common.services.protobuff.PlayerInfo()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
